import 'package:image_picker/image_picker.dart';
import 'package:ride_sharing_user_app/data/api_client.dart';
import 'package:ride_sharing_user_app/features/auth/domain/models/sign_up_body.dart';

abstract class ProfileServiceInterface{
  Future<dynamic> getProfileInfo();
  Future<dynamic> updateProfileInfo({
    required SignUpBody signUpBody,
    XFile? profile, List<MultipartBody>? identityImage,
    Map<String, dynamic>? additionalData,
    List<MultipartBody>? additionalFiles,
    Map<String, dynamic>? oldAdditionalImages,
  });

}