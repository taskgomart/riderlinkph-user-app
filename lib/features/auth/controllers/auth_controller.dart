import 'package:country_code_picker/country_code_picker.dart';
import 'package:image_picker/image_picker.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:ride_sharing_user_app/data/api_checker.dart';
import 'package:ride_sharing_user_app/data/api_client.dart';
import 'package:ride_sharing_user_app/features/auth/domain/enums/verification_from_enum.dart';
import 'package:ride_sharing_user_app/features/auth/domain/models/additional_field_model.dart';
import 'package:ride_sharing_user_app/features/auth/domain/models/sign_up_body.dart';
import 'package:ride_sharing_user_app/features/auth/domain/services/auth_service_interface.dart';
import 'package:ride_sharing_user_app/features/auth/screens/otp_signup_screen.dart';
import 'package:ride_sharing_user_app/features/auth/widgets/manual_auth_waring_bottom_sheet_widget.dart';
import 'package:ride_sharing_user_app/features/dashboard/controllers/bottom_menu_controller.dart';
import 'package:ride_sharing_user_app/features/auth/screens/reset_password_screen.dart';
import 'package:ride_sharing_user_app/features/auth/screens/verification_screen.dart';
import 'package:ride_sharing_user_app/features/dashboard/screens/dashboard_screen.dart';
import 'package:ride_sharing_user_app/features/parcel/controllers/parcel_controller.dart';
import 'package:ride_sharing_user_app/features/ride/controllers/ride_controller.dart';
import 'package:ride_sharing_user_app/features/safety_setup/controllers/safety_alert_controller.dart';
import 'package:ride_sharing_user_app/features/splash/controllers/config_controller.dart';
import 'package:ride_sharing_user_app/helper/country_code_helper.dart';
import 'package:ride_sharing_user_app/helper/display_helper.dart';
import 'package:ride_sharing_user_app/features/profile/controllers/profile_controller.dart';
import 'package:ride_sharing_user_app/helper/login_helper.dart';
import 'package:ride_sharing_user_app/helper/pusher_helper.dart';

class AuthController extends GetxController implements GetxService {
  final AuthServiceInterface authServiceInterface;
  AuthController({required this.authServiceInterface});

  bool _isLoading = false;
  bool _isOtpSending = false;
  String _verificationCode = '';
  bool _isActiveRememberMe = false;
  bool otpVerifying = false;
  String countryDialCode = '+880';
  bool get isLoading => _isLoading;
  bool get isOtpSending => _isOtpSending;
  String get verificationCode => _verificationCode;
  bool get isActiveRememberMe => _isActiveRememberMe;
  bool showNavigationBar = true;

  TextEditingController fNameController = TextEditingController();
  TextEditingController lNameController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController phoneController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  TextEditingController confirmPasswordController = TextEditingController();
  TextEditingController referralCodeController = TextEditingController();

  List<AdditionalFieldModel> _additionalFields = [];
  List<AdditionalFieldModel> get additionalFields => _additionalFields;

  Map<String, TextEditingController> _additionalFieldControllers = {};
  Map<String, TextEditingController> get additionalFieldControllers => _additionalFieldControllers;

  Map<String, FocusNode> _additionalFieldFocusNodes = {};
  Map<String, FocusNode> get additionalFieldFocusNodes => _additionalFieldFocusNodes;
  Map<String, List<XFile>> _additionalFieldFiles = {};
  Map<String, List<XFile>> get additionalFieldFiles => _additionalFieldFiles;
  Map<String, dynamic> _additionalFieldCheckValues = {};
  Map<String, dynamic> get additionalFieldCheckValues => _additionalFieldCheckValues;
  Map<String, String> _additionalFieldPhoneCountryCodes = {};
  Map<String, String> get additionalFieldPhoneCountryCodes => _additionalFieldPhoneCountryCodes;

  final Map<String, dynamic> additionalData = {};
  List<MultipartBody> additionalFiles = [];


  void toggleNavigationBar(){
    showNavigationBar = false;
    update();
  }

  void setCountryCode( String countryCode){
    countryDialCode  = countryDialCode;
    update();
  }

  Future<void> login(String countryCode, String phone, String password) async {
    _isLoading = true;
    update();

    final String fullPhoneNumber = countryCode + phone;
    Response? response = await authServiceInterface.login(phone: fullPhoneNumber, password: password);

    _isLoading = false;

    if (response?.statusCode == 200) {
      disposeAdditionalFields();
      saveUserNumberAndPassword(countryCode, phone, password, true);
      setUserToken(response!.body['data']['token']);
      PusherHelper.initializePusher();
      updateToken();

      await Get.find<ProfileController>().getProfileInfo();
      _navigateLogin(countryCode, phone, password);

    } else if (response?.statusCode == 202) {
      final bool isPhoneNotVerified = response?.body['data']['is_phone_verified'] == 0;

      if (isPhoneNotVerified) {
        if (Get.find<ConfigController>().config?.isFirebaseOtpVerification ?? false) {
          firebaseOtpSend(fullPhoneNumber, from: VerificationForm.login);
        } else if(Get.find<ConfigController>().config?.isSmsGateway ?? false){
          sendOtp(fullPhoneNumber).then((_){
            Get.to(() => VerificationScreen(number: fullPhoneNumber, form: VerificationForm.login));
          });

        }else{
          showCustomSnackBar('sms_gateway_not_integrate'.tr);
        }
      }

    } else if(response?.statusCode == 408){
      Get.bottomSheet(ManualAuthWaringBottomSheetWidget(phoneNumber: phone, from: VerificationForm.resetPassword));
    }else {
      ApiChecker.checkApi(response!);
    }

    update();
  }

  Future<void> logOut() async {
    _isLoading = true;
    update();
    Response? response = await authServiceInterface.logOut();
    if(response!.statusCode == 200){
      Get.back();
      LoginHelper.checkLoginMedium();
      showCustomSnackBar('successfully_logout'.tr, isError: false);
      clearSharedData();
      Get.find<RideController>().clearRideDetails();
      Get.find<ParcelController>().clearParcelModel();
      Get.find<SafetyAlertController>().cancelDriverNeedSafetyStream();
    }else{
      ApiChecker.checkApi(response);
    }
    _isLoading = false;
    update();
  }

  Future<void> register(SignUpBody signUpBody) async {
    _isLoading = true;
    update();

    String countryCode = CountryCodeHelper.getCountryCode(signUpBody.phone!)!;
    String phoneWithoutCountryCode = signUpBody.phone!.substring(countryCode.length);
    await getAdditionalFieldValues();

    Response? response = await authServiceInterface.registration(signUpBody: signUpBody, additionalData: additionalData, additionalFiles: additionalFiles);
    if(response!.statusCode == 200){
       login(countryCode, phoneWithoutCountryCode, signUpBody.password!);
    } else if(response.statusCode == 407){
      Get.bottomSheet(ManualAuthWaringBottomSheetWidget(phoneNumber: phoneWithoutCountryCode, from: VerificationForm.verifyUser));
    }else {
      ApiChecker.checkApi(response);
    }
    _isLoading = false;
    update();

  }

  void _navigateLogin(String code, String phone, String password){
    if (_isActiveRememberMe) {
      saveUserNumberAndPassword(code,phone, password,false);
    } else {
      clearUserNumberAndPassword();
    }
    Get.find<BottomMenuController>().resetNavBar();
    Get.find<BottomMenuController>().navigateToDashboard();
  }

  Future<Response> sendOtp(String phone) async{
    _isOtpSending = true;
    update();

    Response? response = await authServiceInterface.sendOtp(phone: phone);
    if(response!.statusCode == 200){
      _isOtpSending = false;
      showCustomSnackBar('otp_sent_successfully'.tr, isError: false);
    }else{
      _isOtpSending = false;
      ApiChecker.checkApi(response);
    }

    update();
    return response;
  }

  Future<void> firebaseOtpSend(String phoneNumber,{bool canRoute = true, required VerificationForm from})async {
    _isOtpSending = true;
    update();

    await FirebaseAuth.instance.verifyPhoneNumber(
      phoneNumber: phoneNumber,
      verificationCompleted: (PhoneAuthCredential credential) {},
      verificationFailed: (FirebaseAuthException e) {
        _isOtpSending = false;
        update();

        if(e.code == 'invalid-phone-number') {
          showCustomSnackBar('please_submit_a_valid_phone_number'.tr);
        }else{
          showCustomSnackBar(e.message?.replaceAll('_', ' ') ?? '');
        }

      },
      codeSent: (String vId, int? resendToken) {

        _isOtpSending = false;
        update();
        if(canRoute){
          Get.to(() => VerificationScreen(number: phoneNumber, form: from, session: vId));
        }

      },
      codeAutoRetrievalTimeout: (String verificationId) {},
    );


  }

  Future<Response> checkOAuth({required String countryCode,  required String number}) async{
    _isOtpSending = true;
    update();
    Response? response = await authServiceInterface.isUserRegistered(phone: countryCode+number);
    if(response!.statusCode == 200){
      _isOtpSending = false;
    }else{
      _isOtpSending = false;
      ApiChecker.checkApi(response);
    }
    update();
    return response;
  }

  Future<Response> otpVerification(String phone, String otp, { required VerificationForm from, String? session}) async{
    otpVerifying = true;
    update();
    Response? response;
    if(Get.find<ConfigController>().config?.isFirebaseOtpVerification ?? false){
      response = await authServiceInterface.verifyFirebaseOtp(phone: phone, otp: otp,session: session!);
    }else{
      response = await authServiceInterface.verifyOtp(phone: phone, otp: otp);
    }
    if(response!.statusCode == 200) {
      otpVerifying = false;
      _verificationCode = '';
      updateVerificationCode('');
      if(from == VerificationForm.login) {
        setUserToken(response.body['data']['token']);
        updateToken();
        await Get.find<ProfileController>().getProfileInfo();
        Get.find<BottomMenuController>().navigateToDashboard();

      }else if(from == VerificationForm.resetPassword){
        otpVerifying = false;
        Get.to(() =>  ResetPasswordScreen(phoneNumber: phone));
      }else if(from == VerificationForm.verifyUser){
        registrationFromOtp(
          SignUpBody(
              fName: fNameController.text.trim(),
              lName: lNameController.text.trim(),
              phone: countryDialCode + phoneController.text.trim(),
              password: passwordController.text.trim(),
              confirmPassword: confirmPasswordController.text.trim(),
              referralCode: referralCodeController.text.trim()
          ), updateFromRegistration: true
        );
      }

    }else if(response.statusCode == 406){
      Get.off(()=> OtpSignupScreen(phoneNumber: phone));
    }else{
      otpVerifying = false;
      ApiChecker.checkApi(response);
    }
    otpVerifying = false;
    update();
    return response;
  }


  Future<void> registrationFromOtp(SignUpBody signUpBody, {required bool updateFromRegistration}) async {
    _isLoading = true;
    update();
    await getAdditionalFieldValues();
    Response? response = await authServiceInterface.registrationFromOtp(signUpBody, updateFromRegistration: updateFromRegistration, additionalData: additionalData, additionalFiles: additionalFiles);

    _isLoading = false;

    if (response?.statusCode == 200) {
      disposeAdditionalFields();
      setUserToken(response!.body['data']['token']);
      PusherHelper.initializePusher();
      updateToken();

      await Get.find<ProfileController>().getProfileInfo();
      Get.find<BottomMenuController>().resetNavBar();
      Get.find<BottomMenuController>().navigateToDashboard();

    }else {
      ApiChecker.checkApi(response!);
    }

    update();
  }

  Future<void> forgetPassword(String phone) async {
    _isLoading = true;
    update();
    Response? response = await authServiceInterface.forgetPassword(phone);
    if (response!.statusCode  == 200) {
      _isLoading = false;
      showCustomSnackBar('successfully_sent_otp'.tr, isError: false);
    }else{
      _isLoading = false;
      showCustomSnackBar('invalid_number'.tr);
    }
    update();
  }

  Future<void> updateToken() async {
    await authServiceInterface.updateToken();
  }

  Future<void> resetPassword(String phone, String password) async {
    _isLoading = true;
    update();
    Response? response = await authServiceInterface.resetPassword(phone, password);
    if (response!.statusCode == 200) {

      showCustomSnackBar('password_change_successfully'.tr, isError: false);
      LoginHelper.checkLoginMedium();
    }else{
      showCustomSnackBar(response.body['message']);
    }
    _isLoading = false;
    update();
  }

  Future<void> changePassword(String password, String newPassword) async {
    _isLoading = true;
    update();
    Response? response = await authServiceInterface.changePassword(password, newPassword);
    if (response!.statusCode == 200) {
      Get.offAll(()=> const DashboardScreen());
      showCustomSnackBar('password_change_successfully'.tr, isError: false);
    }else{
      ApiChecker.checkApi(response);
    }
    _isLoading = false;
    update();
  }

  void updateVerificationCode(String query, {bool isUpdate = true}) {
    _verificationCode = query;
    if(isUpdate){
      update();
    }
  }

  void toggleRememberMe() {
    _isActiveRememberMe = !_isActiveRememberMe;
    update();
  }

  void setRememberMe() {
    _isActiveRememberMe = true;
  }

  bool isLoggedIn() {
    return authServiceInterface.isLoggedIn();
  }

  Future <bool> clearSharedData() async {
    return authServiceInterface.clearSharedData();
  }

  void saveUserNumberAndPassword(String code,String number, String password,bool externalUser) {
    authServiceInterface.saveUserNumberAndPassword(code, number, password, externalUser);
  }

  String getUserNumber(bool externalUser) {
    return authServiceInterface.getUserNumber(externalUser);
  }

  String getLoginCountryCode(bool externalUser) {
    return authServiceInterface.getLoginCountryCode(externalUser);
  }
  String getUserPassword(bool externalUser) {
    return authServiceInterface.getUserPassword(externalUser);
  }

  Future<bool> clearUserNumberAndPassword() async {
    return authServiceInterface.clearUserNumberAndPassword();
  }

  String getUserToken() {
    return authServiceInterface.getUserToken();
  }

  Future <void> setUserToken(String token) async{
    authServiceInterface.saveUserToken(token);
  }

  Future<void> permanentlyDelete() async {
    _isLoading = true;
    update();
    Response? response = await authServiceInterface.permanentlyDelete();
    if(response!.statusCode == 200){
      Get.back();
      LoginHelper.checkLoginMedium();
      showCustomSnackBar('successfully_delete_account'.tr, isError: false);
      clearSharedData();
      Get.find<SafetyAlertController>().cancelDriverNeedSafetyStream();
    }else{
      ApiChecker.checkApi(response);
    }
    _isLoading = false;
    update();
  }


  void saveFindingRideCreatedTime(){
    authServiceInterface.saveRideCreatedTime(DateTime.now());
  }

  void remainingFindingRideTime() async{
    String time = await authServiceInterface.remainingTime();
    if(time.isNotEmpty){
      DateTime oldTime = DateTime.parse(time);
      DateTime newTime = DateTime.now();
      int diff =  newTime.difference(oldTime).inSeconds;
      Get.find<RideController>().resumeCountingTimeState(diff);
    }
  }


  void loadAdditionalFields(bool fromOtp) {
    _additionalFields = [];
    if(fromOtp){
      (Get.find<ConfigController>().config?.additionalFieldList ?? []).forEach((field){
        if(field.isRequired){
          _additionalFields.add(field);
        }
      });
    }else{
      _additionalFields = Get.find<ConfigController>().config?.additionalFieldList ?? [];
    }
    _initAdditionalFieldControllers();
  }

  void _initAdditionalFieldControllers() {
    for (var controller in _additionalFieldControllers.values) {
      controller.dispose();
    }
    for (var node in _additionalFieldFocusNodes.values) {
      node.dispose();
    }
    _additionalFieldControllers.clear();
    _additionalFieldFocusNodes.clear();
    _additionalFieldFiles.clear();
    _additionalFieldCheckValues.clear();
    _additionalFieldPhoneCountryCodes.clear();

    for (var field in _additionalFields) {
      if (field.fieldType == AdditionalFieldType.checkbox) {
        if (field.options?.isNotEmpty == true) {
          _additionalFieldCheckValues[field.id] = <String>[];
        } else {
          _additionalFieldCheckValues[field.id] = false;
        }
      } else if (field.fieldType == AdditionalFieldType.radio || field.fieldType == AdditionalFieldType.select) {
        _additionalFieldCheckValues[field.id] = '';
      } else if (field.fieldType == AdditionalFieldType.file) {
        _additionalFieldFiles[field.id] = [];
      } else {
        _additionalFieldControllers[field.id] = TextEditingController();
        _additionalFieldFocusNodes[field.id] = FocusNode();
        if (field.fieldType == AdditionalFieldType.phone) {
          _additionalFieldPhoneCountryCodes[field.id] = CountryCode.fromCountryCode(Get.find<ConfigController>().config!.countryCode!).dialCode ?? '+880';
        }
      }
    }
  }

  void setAdditionalFieldFile(String fieldId, List<XFile> files) {
    _additionalFieldFiles[fieldId] = files;
    update();
  }

  void setAdditionalFieldCheckValue(String fieldId, dynamic value) {
    _additionalFieldCheckValues[fieldId] = value;
    update();
  }

  void setAdditionalFieldPhoneCountryCode(String fieldId, String countryCode) {
    _additionalFieldPhoneCountryCodes[fieldId] = countryCode;
    update();
  }


  Future<Map<String, dynamic>> getAdditionalFieldValues() async{
    additionalFiles = [];
    for (var field in _additionalFields) {
      if (field.fieldType == AdditionalFieldType.checkbox || field.fieldType == AdditionalFieldType.radio || field.fieldType == AdditionalFieldType.select) {
        additionalData[field.title] = _additionalFieldCheckValues[field.id] ?? (field.options?.isNotEmpty == true ? [] : false);
      } else if (field.fieldType == AdditionalFieldType.file) {
        _additionalFieldFiles[field.id]?.forEach((file){
          additionalFiles.add(MultipartBody('additional_data[${field.title}][]', file));
        });
      } else {
        String value = _additionalFieldControllers[field.id]?.text.trim() ?? '';
        if (field.fieldType == AdditionalFieldType.phone && value.isNotEmpty) {
          value = (_additionalFieldPhoneCountryCodes[field.id] ?? '') + value;
        }
        additionalData[field.title] = value;
      }
    }
    return additionalData;
  }

  String? validateAdditionalFields() {
    for (var field in _additionalFields) {
      if (!field.isRequired) continue;

      if (field.fieldType == AdditionalFieldType.checkbox) {
        final value = _additionalFieldCheckValues[field.id];
        if (field.options?.isNotEmpty == true) {
          if (value is! List || value.isEmpty) {
            return field.title;
          }
        } else {
          if (value != true) {
            return field.title;
          }
        }
      } else if (field.fieldType == AdditionalFieldType.radio || field.fieldType == AdditionalFieldType.select) {
        final value = _additionalFieldCheckValues[field.id] as String?;
        if (value == null || value.isEmpty) {
          return field.title;
        }
      } else if (field.fieldType == AdditionalFieldType.file) {
        if (_additionalFieldFiles[field.id] == null || _additionalFieldFiles[field.id]!.isEmpty) {
          return field.title;
        }
      } else {
        final value = _additionalFieldControllers[field.id]?.text.trim() ?? '';
        if (value.isEmpty) {
          return field.title;
        }
      }
    }
    return null;
  }

  void disposeAdditionalFields() {
    for (var controller in _additionalFieldControllers.values) {
      controller.dispose();
    }
    for (var node in _additionalFieldFocusNodes.values) {
      node.dispose();
    }
    _additionalFieldControllers = {};
    _additionalFieldFocusNodes = {};
    _additionalFieldFiles = {};
    _additionalFieldCheckValues = {};
    _additionalFieldPhoneCountryCodes = {};
    additionalFiles = [];
    fNameController.clear();
    lNameController.clear();
    emailController.clear();
    phoneController.clear();
    passwordController.clear();
    confirmPasswordController.clear();
    referralCodeController.clear();
  }

}
