import 'user_profile_data.dart';

class UserProfileResponse {
  final String message;
  final UserProfileData data;

  UserProfileResponse({required this.message, required this.data});

  factory UserProfileResponse.fromJson(Map<String, dynamic> json) => UserProfileResponse(
        message: json['message'] ?? '',
        data: UserProfileData.fromJson(json['data']),
      );
}