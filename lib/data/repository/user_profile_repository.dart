import '../api/user_profile_api_service.dart';
import '../remote/request/user_edit_profile_request.dart';
import '../remote/response/user_profile_response.dart';

class UserProfileRepository {
  final UserProfileApiService apiService;
  UserProfileRepository(this.apiService);

  Future<UserProfileResponse> getUserProfile(String token) async {
    return await apiService.getUserProfile(token);
  }

  Future<UserProfileResponse> updateUserProfile(
      String token, UserEditProfileRequest request) async {
    return await apiService.updateUserProfile(request, token);
  }
}