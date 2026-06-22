import 'dart:convert';
import 'dart:developer';

import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:get/get.dart';
import 'package:ride_sharing_user_app/data/api_client.dart';
import 'package:ride_sharing_user_app/features/auth/domain/models/sign_up_body.dart';
import 'package:ride_sharing_user_app/features/auth/domain/repositories/auth_repository_interface.dart';
import 'package:ride_sharing_user_app/util/app_constants.dart';
import 'package:ride_sharing_user_app/features/address/domain/models/address_model.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AuthRepository implements AuthRepositoryInterface{
  final ApiClient apiClient;
  final SharedPreferences sharedPreferences;
  AuthRepository({required this.apiClient, required this.sharedPreferences});

  final FlutterSecureStorage _storage = const FlutterSecureStorage(
    aOptions: AndroidOptions(encryptedSharedPreferences: true),
    iOptions: IOSOptions(accessibility: KeychainAccessibility.first_unlock),
  );

  // In-memory cache for sync access to secure data
  String _cachedToken = '';
  String _cachedUserPassword = '';
  String _cachedExternalUserPassword = '';
  bool _cacheInitialized = false;

  Future<void> _ensureCacheInitialized() async {
    if (_cacheInitialized) return;
    _cachedToken = (await _storage.read(key: AppConstants.token)) ?? '';
    _cachedUserPassword = (await _storage.read(key: AppConstants.userPassword)) ?? '';
    _cachedExternalUserPassword = (await _storage.read(key: AppConstants.externalUserPassword)) ?? '';
    _cacheInitialized = true;
  }

  @override
  Future<Response?> login({required String phone, required String password}) async {
    return await apiClient.postData(AppConstants.loginUri, {"phone_or_email": phone, "password": password});
  }

  @override
  Future<Response?> externalLogin({required String phone, required String password}) async {
    return await apiClient.postData(AppConstants.externalLoginUri, {"phone_or_email": phone, "token": password});
  }

  @override
  Future<Response?> logOut() async {
    return await apiClient.postData(AppConstants.logOutUri, {});
  }



  @override
  Future<Response?> registration({required SignUpBody signUpBody, Map<String, dynamic>? additionalData, List<MultipartBody>? additionalFiles}) async {
    Map<String, String> body = <String, String> {
      'first_name': signUpBody.fName ?? '',
      'last_name': signUpBody.lName ?? '',
      "phone" : signUpBody.phone ?? '',
      "password" : signUpBody.password ?? '',
      "confirm_password" : signUpBody.confirmPassword ?? '',
      "referral_code" : signUpBody.referralCode ?? '',
      "email" : signUpBody.email ?? ''
    };

    Map<String, String> bodyData = {};

    additionalData?.forEach((key, value){
      if(value is String){
        bodyData['additional_data[$key]'] = value;
      }else if(value is List<dynamic>){
        for(int i = 0 ; i< value.length ; i++){
          bodyData['additional_data[$key][$i]'] = value[i];
        }
      }
    });

    return await apiClient.postMultipartData(
        AppConstants.registration,
        body,
        MultipartBody('', null),
        additionalFiles ?? [],
        additionalData: bodyData,
    );
  }



  @override
  Future<Response?> sendOtp({required String phone}) async {
    return await apiClient.postData(AppConstants.sendOTP,
        {"phone_or_email": phone});
  }

  @override
  Future<Response?> isUserRegistered({required String phone}) async {
    return await apiClient.postData(AppConstants.checkRegisteredUserUri,
        {"phone_or_email": phone});
  }

  @override
  Future<Response?> verifyOtp({required String phone, required String otp}) async {
    return await apiClient.postData(AppConstants.otpVerification,
        {"phone_or_email": phone,
          "otp": otp
        });
  }


  @override
  Future<Response?> verifyFirebaseOtp({required String phone, required String otp, required String session}) async {
    return await apiClient.postData(AppConstants.otpFirebaseVerification,
        {"phone_or_email": phone,
          "code": otp,
          "session_info": session
        });
  }


  @override
  Future<Response?> otpLogin({required String phone, required String otp}) async {
    return await apiClient.postData(AppConstants.otpLogin,
        {"phone_or_email": phone,
          "otp": otp
        });
  }


  @override
  Future<Response?> resetPassword(String phoneOrEmail, String password) async {
    return await apiClient.postData(AppConstants.resetPassword,
      { "phone_or_email": phoneOrEmail,
        "password": password,},
    );
  }

  @override
  Future<Response?> changePassword(String oldPassword, String password) async {
    return await apiClient.postData(AppConstants.changePassword,
      { "password": oldPassword,
        "new_password": password,
      },
    );
  }

  @override
  Future<Response?> updateToken() async {
    String? deviceToken;
    if (GetPlatform.isIOS && !GetPlatform.isWeb) {
      FirebaseMessaging.instance.setForegroundNotificationPresentationOptions(alert: true, badge: true, sound: true);
      NotificationSettings settings = await FirebaseMessaging.instance.requestPermission(
        alert: true, announcement: false, badge: true, carPlay: false,
        criticalAlert: false, provisional: false, sound: true,
      );
      if(settings.authorizationStatus == AuthorizationStatus.authorized) {
        deviceToken = await _saveDeviceToken();
      }
    }else {
      deviceToken = await _saveDeviceToken();
    }

    if(!GetPlatform.isWeb){

        FirebaseMessaging.instance.subscribeToTopic(AppConstants.topic);

    }
    return await apiClient.postData(AppConstants.fcmTokenUpdate, {"_method": "put", "fcm_token": deviceToken});
  }

  Future<String?> _saveDeviceToken() async {
    String? deviceToken = '@';
    try {
      deviceToken = await FirebaseMessaging.instance.getToken();
    }catch(e) {
      // token retrieval failed
    }
    // deviceToken value intentionally not logged
    return deviceToken;
  }



  @override
  Future<Response?> forgetPassword(String? phone) async {
    return await apiClient.postData(AppConstants.configUri, {"phone_or_email": phone});
  }

  @override
  Future<Response?> verifyToken(String phone, String otp) async {
    return await apiClient.postData(AppConstants.configUri, {"phone_or_email": phone.substring(1,phone.length-1), "otp": otp});
  }


  @override
  Future<Response?> checkEmail(String email) async {
    return await apiClient.postData(AppConstants.configUri, {"email": email});
  }

  @override
  Future<Response?> verifyEmail(String email, String token) async {
    return await apiClient.postData(AppConstants.configUri, {"email": email, "token": token});
  }



  @override
  Future<Response?> verifyPhone(String phone, String otp) async {
    return await apiClient.postData(AppConstants.configUri, {"phone": phone, "otp": otp});
  }

  @override
  Future<bool?> saveUserToken(String token) async {
    Address? address;
    try {
      address = Address.fromJson(jsonDecode(sharedPreferences.getString(AppConstants.userAddress)!));
      // ignore: empty_catches
    }catch(e) {
    }
    apiClient.updateHeader(token, address);
    return await _storage.write(key: AppConstants.token, value: token);

  }


  @override
  String getUserToken() {
    if (!_cacheInitialized) {
      // Kick off async init but return cached or empty immediately
      _ensureCacheInitialized();
      return _cachedToken;
    }
    return _cachedToken;
  }

  @override
  bool isLoggedIn() {
    return _cachedToken.isNotEmpty;
  }

  @override
  bool clearSharedData() {
    sharedPreferences.remove(AppConstants.token);
    sharedPreferences.remove(AppConstants.userAddress);
    _cachedToken = '';
    _cachedUserPassword = '';
    _cachedExternalUserPassword = '';
    _cacheInitialized = true; // keep initialized, just cleared
    // Also clear secure storage
    _storage.delete(key: AppConstants.token);
    _storage.delete(key: AppConstants.userPassword);
    _storage.delete(key: AppConstants.externalUserPassword);
    return true;
  }

  @override
  Future<void> saveUserNumberAndPassword(String code, String number, String password, bool externalUser) async {
    await _ensureCacheInitialized();
    if(externalUser){
      try {
        await _storage.write(key: AppConstants.externalUserPassword, value: password);
        await sharedPreferences.setString(AppConstants.externalUserPhone, number);
        await sharedPreferences.setString(AppConstants.externalUserCountryCode, code);
        _cachedExternalUserPassword = password;
      } catch (e) {
        rethrow;
      }
    }else{
      try {
        await _storage.write(key: AppConstants.userPassword, value: password);
        await sharedPreferences.setString(AppConstants.userNumber, number);
        await sharedPreferences.setString(AppConstants.loginCountryCode, code);
        _cachedUserPassword = password;
      } catch (e) {
        rethrow;
      }
    }
  }

  @override
  String getUserNumber(bool externalUser) {
    if(externalUser){
      return sharedPreferences.getString(AppConstants.externalUserPhone) ?? "";
    }else{
      return sharedPreferences.getString(AppConstants.userNumber) ?? "";
    }
  }

  @override
  String getLoginCountryCode(bool externalUser) {
    if(externalUser){
      return sharedPreferences.getString(AppConstants.externalUserCountryCode) ?? "";
    }else{
      return sharedPreferences.getString(AppConstants.loginCountryCode) ?? "";
    }
  }



  @override
  String getUserPassword(bool externalUser) {
    if (!_cacheInitialized) {
      _ensureCacheInitialized();
      return externalUser ? _cachedExternalUserPassword : _cachedUserPassword;
    }
    return externalUser ? _cachedExternalUserPassword : _cachedUserPassword;
  }



  @override
  Future<bool> clearUserNumberAndPassword() async {
    await _storage.delete(key: AppConstants.userPassword);
    _cachedUserPassword = '';
    return await sharedPreferences.remove(AppConstants.userNumber);
  }

  @override
  bool clearSharedAddress(){
    sharedPreferences.remove(AppConstants.userAddress);
    return true;
  }

  @override
  Future add(value) {
    // TODO: implement add
    throw UnimplementedError();
  }

  @override
  Future delete(String id) {
    // TODO: implement delete
    throw UnimplementedError();
  }

  @override
  Future get(String id) {
    // TODO: implement get
    throw UnimplementedError();
  }

  @override
  Future getList({int? offset = 1}) {
    // TODO: implement getList
    throw UnimplementedError();
  }

  @override
  Future update(value, {int? id}) {
    // TODO: implement update
    throw UnimplementedError();
  }

  @override
  Future permanentlyDelete() async{
    return await apiClient.postData(AppConstants.deleteAccount, {});
  }

  @override
  Future<void> saveRideCreatedTime(DateTime dateTime) async {
    await sharedPreferences.setString('DateTime', dateTime.toString());
  }

  @override
  Future<String> remainingTime() async{
    return sharedPreferences.getString('DateTime') ?? '';
  }

  @override
  Future<dynamic> registrationFromOtp(SignUpBody signUpBody, {required bool updateFromRegistration, Map<String, dynamic>? additionalData, List<MultipartBody>? additionalFiles}) async{

    Map<String, String> body = <String, String> {
      'first_name': signUpBody.fName ?? '',
      'last_name': signUpBody.lName ?? '',
      "phone" : signUpBody.phone ?? '',
      "password" : signUpBody.password ?? '',
      "confirm_password" : signUpBody.confirmPassword ?? '',
      "referral_code" : signUpBody.referralCode ?? ''
    };

    Map<String, String> bodyData = {};

    additionalData?.forEach((key, value){
      if(value is String){
        bodyData['additional_data[$key]'] = value;
      }else if(value is List<dynamic>){
        for(int i = 0 ; i< value.length ; i++){
          bodyData['additional_data[$key][$i]'] = value[i];
        }
      }
    });

   return await apiClient.postMultipartData(
     updateFromRegistration ?
     AppConstants.otpLoginAfterUpdateData :
     AppConstants.registrationFromOtp,
     body,
     MultipartBody('', null),
     additionalFiles ?? [],
     additionalData: bodyData
   );
  }
}
