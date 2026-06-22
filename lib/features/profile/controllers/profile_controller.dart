import 'dart:async';
import 'package:country_code_picker/country_code_picker.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:ride_sharing_user_app/data/api_checker.dart';
import 'package:ride_sharing_user_app/data/api_client.dart';
import 'package:ride_sharing_user_app/features/auth/domain/models/additional_field_model.dart';
import 'package:ride_sharing_user_app/features/auth/domain/models/sign_up_body.dart';
import 'package:ride_sharing_user_app/features/profile/domain/models/profile_model.dart';
import 'package:ride_sharing_user_app/features/profile/domain/services/profile_service_interface.dart';
import 'package:ride_sharing_user_app/features/splash/controllers/config_controller.dart';
import 'package:ride_sharing_user_app/helper/country_code_helper.dart';
import 'package:ride_sharing_user_app/helper/file_validation_helper.dart';

class ProfileController extends GetxController implements GetxService {
  final ProfileServiceInterface profileServiceInterface;
  ProfileController({required this.profileServiceInterface});

  final List<String> _identityTypeList = ['passport', 'driving_license', 'nid'];
  XFile? _pickedProfileFile;
  List<MultipartBody> multipartList = [];
  XFile? _pickedIdentityImageFront;
  XFile identityImage = XFile('');
  XFile? _pickedIdentityImageBack;
  bool isLoading = false;
  String _identityType = '';
  ProfileModel? profileModel;
  bool isUpdating = false;

  XFile? get pickedProfileFile => _pickedProfileFile;
  XFile? get pickedIdentityImageFront => _pickedIdentityImageFront;
  XFile? get pickedIdentityImageBack => _pickedIdentityImageBack;
  List<XFile> identityImages = [];
  List<String> get identityTypeList => _identityTypeList;
  String get identityType => _identityType;

  ///For Additional Data update
  List<AdditionalFieldModel> _additionalFields = [];
  List<AdditionalFieldModel> get additionalFields => _additionalFields;

  Map<String, TextEditingController> _additionalFieldControllers = {};
  Map<String, TextEditingController> get additionalFieldControllers => _additionalFieldControllers;

  Map<String, FocusNode> _additionalFieldFocusNodes = {};
  Map<String, FocusNode> get additionalFieldFocusNodes => _additionalFieldFocusNodes;
  Map<String, List<dynamic>> _additionalFieldFiles = {};
  Map<String, List<dynamic>> get additionalFieldFiles => _additionalFieldFiles;
  Map<String, dynamic> _additionalFieldCheckValues = {};
  Map<String, dynamic> get additionalFieldCheckValues => _additionalFieldCheckValues;
  Map<String, String> _additionalFieldPhoneCountryCodes = {};
  Map<String, String> get additionalFieldPhoneCountryCodes => _additionalFieldPhoneCountryCodes;

  final Map<String, dynamic> additionalData = {};
  List<MultipartBody> additionalFiles = [];
  Map<String, dynamic> oldAdditionalImages = {};

  void setIdentityType (String setValue, {bool notify = true}) {
    if(setValue.isEmpty) {
      _identityType = _identityTypeList[0];
    }else {
      _identityType = setValue;
    }
    if(notify) {
      update();
    }
  }

  Future<bool> pickImage(bool isBack, bool isProfile) async {
     if(isProfile){
      _pickedProfileFile = (await FileValidationHelper.validateAndPickImage(source: ImageSource.gallery))!;

    } else{
       identityImage = (await FileValidationHelper.validateAndPickImage(source: ImageSource.gallery))!;
       identityImages.add(identityImage);
       multipartList.add(MultipartBody('identity_images[]', identityImage));
    }
     update();
     return true;
  }

  void removeImage(int index){
    identityImages.removeAt(index);
    multipartList.removeAt(index);
    update();
  }

  void clearSelectedImage(){
    _pickedProfileFile = null;
  }

  String customerName() {
    if(profileModel != null) {
      return '${profileModel!.data!.firstName ?? ''} ${profileModel!.data!.lastName ?? ''}';
    }else {
      return 'Guest';
    }
  }

  String customerFirstName() {
    if(profileModel != null) {
      return profileModel!.data!.firstName ?? '';
    }else {
      return 'Guest';
    }
  }

  Future<Response> getProfileInfo() async {
    Response? response = await profileServiceInterface.getProfileInfo();
    if(response!.statusCode == 200) {
      profileModel = ProfileModel.fromJson(response.body);
    }else{
      ApiChecker.checkApi(response);
    }
    isLoading = false;
    update();
    return response;
  }

  Future<Response> updateProfile(SignUpBody signUpBody) async {
    isUpdating = true;
    update();

    await getAdditionalFieldValues();

    Response? response = await profileServiceInterface.updateProfileInfo(
        signUpBody: signUpBody, profile: _pickedProfileFile, identityImage: multipartList,
        additionalData: additionalData, additionalFiles: additionalFiles,
        oldAdditionalImages: oldAdditionalImages
    );
    if(response!.statusCode == 200){
      Get.back();
      getProfileInfo();
      identityImages= [];
      multipartList = [];
      disposeAdditionalFields();
    }else{
      ApiChecker.checkApi(response);
    }
    isUpdating = false;
    update();
    return response;
  }

  void loadAdditionalFields() {
    _additionalFields = Get.find<ConfigController>().config?.additionalFieldList ?? [];

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

          profileModel?.data?.additionalData?.forEach((additionData){
            if(additionData.title == field.title && additionData.type == field.fieldType.name){
              _additionalFieldCheckValues[field.id] = additionData.value ?? [];
            }
          });
        } else {
          _additionalFieldCheckValues[field.id] = false;

          profileModel?.data?.additionalData?.forEach((additionData){
            if(additionData.title == field.title && additionData.type == field.fieldType.name){
              _additionalFieldCheckValues[field.id] = (additionData.value?.isNotEmpty == true && additionData.value![0] == '1');
            }
          });
        }
      }
      else if (field.fieldType == AdditionalFieldType.radio || field.fieldType == AdditionalFieldType.select) {
        _additionalFieldCheckValues[field.id] = '';

        profileModel?.data?.additionalData?.forEach((additionData){
          if(additionData.title == field.title && additionData.type == field.fieldType.name){
            _additionalFieldCheckValues[field.id] = additionData.value?[0] ?? '';
          }
        });
      }
      else if (field.fieldType == AdditionalFieldType.file) {
        _additionalFieldFiles[field.id] = [];

        profileModel?.data?.additionalData?.forEach((additionData){
          if(additionData.title == field.title && additionData.type == field.fieldType.name){
            additionData.value?.forEach((v) {
              _additionalFieldFiles[field.id]?.add(v);
            });
          }
        });
      } else {
        _additionalFieldFocusNodes[field.id] = FocusNode();
        _additionalFieldControllers[field.id] = TextEditingController();
        if (field.fieldType == AdditionalFieldType.phone) {
          _additionalFieldPhoneCountryCodes[field.id] = CountryCode.fromCountryCode(Get.find<ConfigController>().config!.countryCode!).dialCode ?? '+880';
        }

        profileModel?.data?.additionalData?.forEach((additionData){
          if(additionData.title == field.title && additionData.type == field.fieldType.name){
            String phoneWithCountry = additionData.value?[0] ?? '';
            if (field.fieldType == AdditionalFieldType.phone && phoneWithCountry.isNotEmpty) {
              String? countryCode = CountryCodeHelper.getCountryCode(phoneWithCountry);
              if (countryCode != null) {
                _additionalFieldPhoneCountryCodes[field.id] = countryCode;
                _additionalFieldControllers[field.id]?.text = phoneWithCountry.substring(countryCode.length);
              } else {
                _additionalFieldControllers[field.id]?.text = phoneWithCountry;
              }
            } else {
              _additionalFieldControllers[field.id]?.text = phoneWithCountry;
            }
          }
        });
      }
    }
  }

  void setAdditionalFieldFile(String fieldId, List<dynamic> files) {
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
    additionalData.clear();
    oldAdditionalImages.clear();
    for (var field in _additionalFields) {
      if (field.fieldType == AdditionalFieldType.checkbox || field.fieldType == AdditionalFieldType.radio || field.fieldType == AdditionalFieldType.select) {
        additionalData[field.title] = _additionalFieldCheckValues[field.id] ?? (field.options?.isNotEmpty == true ? [] : false);
      } else if (field.fieldType == AdditionalFieldType.file) {
        _additionalFieldFiles[field.id]?.forEach((file){
          if(file is XFile){
            additionalFiles.add(MultipartBody('additional_data[${field.title}][]', file));
          }else if(file is String){
            if (oldAdditionalImages[field.title] == null) {
              oldAdditionalImages[field.title] = <String>[];
            }
            oldAdditionalImages[field.title].add(file);
          }

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
    oldAdditionalImages = {};
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

}