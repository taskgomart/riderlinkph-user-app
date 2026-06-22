import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:ride_sharing_user_app/data/api_client.dart';
import 'package:ride_sharing_user_app/features/auth/domain/models/sign_up_body.dart';
import 'package:ride_sharing_user_app/features/profile/domain/repositories/profile_repository_interface.dart';
import 'package:ride_sharing_user_app/util/app_constants.dart';

class ProfileRepository implements ProfileRepositoryInterface{
  final ApiClient apiClient;
  ProfileRepository({required this.apiClient});

  @override
  Future<Response?> getProfileInfo() async {
    return await apiClient.getData(AppConstants.profileInfo);
  }

  @override
  Future<Response?> updateProfileInfo({
    required SignUpBody signUpBody,
    XFile? profile, List<MultipartBody>? identityImage,
    Map<String, dynamic>? additionalData,
    List<MultipartBody>? additionalFiles,
    Map<String, dynamic>? oldAdditionalImages,
  }) async {
    Map<String, String> fields = <String, String> {
      '_method': 'put',
      'first_name': signUpBody.fName ?? '',
      'last_name': signUpBody.lName ?? '',
      "identification_number" : signUpBody.identificationNumber ?? '',
      "identification_type" : signUpBody.identificationType ?? '',
      "email": signUpBody.email ?? ''
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

    oldAdditionalImages?.forEach((key, value){
      for(int i = 0 ; i< value.length ; i++){
        bodyData['existing_additional_data[$key][$i]'] = value[i];
      }
    });

    List<MultipartBody> multipartList = [];
    multipartList.addAll(identityImage ?? []);
    multipartList.addAll(additionalFiles ?? []);

    return await apiClient.postMultipartData(
        AppConstants.updateProfileInfo,
        fields, MultipartBody('profile_image',profile),
        multipartList,
        additionalData: bodyData
    );
  }

}