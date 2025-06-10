import 'package:elderly_care/data/api/nurse_profile_api_service.dart';

class NurseProfileResponse {
  final String message;
  final NurseProfileData data;

  NurseProfileResponse({required this.message, required this.data});

  factory NurseProfileResponse.fromJson(Map<String, dynamic> json) =>
      NurseProfileResponse(
        message: json['message'] ?? '',
        data: NurseProfileData.fromJson(json['data'] ?? {}),
      );
}