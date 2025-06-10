import 'package:dio/dio.dart';
import '../remote/request/user_edit_profile_request.dart';
import '../remote/response/user_profile_response.dart';

class UserProfileApiService {
  final String baseUrl;
  final Dio _dio;

  UserProfileApiService(this.baseUrl) : _dio = Dio(BaseOptions(baseUrl: baseUrl));

  Future<UserProfileResponse> getUserProfile(String token) async {
    try {
      final response = await _dio.get(
        '/user/profile',
        options: Options(
          headers: {'Authorization': 'Bearer $token'},
        ),
      );
      return UserProfileResponse.fromJson(response.data);
    } on DioException catch (e) {
      final data = e.response?.data;
      throw Exception('Failed to fetch user profile: $data');
    }
  }

  Future<UserProfileResponse> updateUserProfile(
      UserEditProfileRequest request, String token) async {
    try {
      final response = await _dio.put(
        '/user/profile',
        data: request.toJson(),
        options: Options(
          headers: {
            'Authorization': 'Bearer $token',
            'Content-Type': 'application/json',
          },
        ),
      );
      return UserProfileResponse.fromJson(response.data);
    } on DioException catch (e) {
      final data = e.response?.data;
      throw Exception('Failed to update user profile: $data');
    }
  }
}