import 'package:image_picker/image_picker.dart';
import 'package:ride_sharing_user_app/data/api_client.dart';
import 'package:ride_sharing_user_app/features/auth/domain/models/sign_up_body.dart';
import 'package:ride_sharing_user_app/features/profile/domain/repositories/profile_repository_interface.dart';
import 'package:ride_sharing_user_app/features/profile/domain/services/profile_service_interface.dart';

class ProfileService implements ProfileServiceInterface{
  ProfileRepositoryInterface profileRepositoryInterface;
  ProfileService({required this.profileRepositoryInterface});

  @override
  Future getProfileInfo() async {
    return await profileRepositoryInterface.getProfileInfo();
  }

  @override
  Future updateProfileInfo({
    required SignUpBody signUpBody,
    XFile? profile, List<MultipartBody>? identityImage,
    Map<String, dynamic>? additionalData,
    List<MultipartBody>? additionalFiles,
    Map<String, dynamic>? oldAdditionalImages,
  }) async{
    return await profileRepositoryInterface.updateProfileInfo(
        signUpBody: signUpBody,
        profile: profile, identityImage: identityImage,
        additionalFiles: additionalFiles, additionalData: additionalData,
        oldAdditionalImages: oldAdditionalImages
    );
  }

}