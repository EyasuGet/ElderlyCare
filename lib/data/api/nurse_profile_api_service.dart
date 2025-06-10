import 'package:dio/dio.dart';
import 'package:elderly_care/data/remote/request/nurse_profile_request.dart';
import 'package:elderly_care/data/remote/response/nurse_profile_response.dart';

class NurseProfileData {
  final String name;
  final String id;
  final String email;
  final List<String> assignedElders;
  final String phoneNo;
  final String address;
  final String dateOfBirth;

  NurseProfileData({
    required this.name,
    required this.id,
    required this.email,
    required this.assignedElders,
    required this.phoneNo,
    required this.address,
    required this.dateOfBirth,
  });

  factory NurseProfileData.fromJson(Map<String, dynamic> json) => NurseProfileData(
        name: json['name'] ?? '',
        id: json['id'] ?? '',
        email: json['email'] ?? '',
        assignedElders: (json['assignedElders'] as List<dynamic>? ?? []).map((e) => e.toString()).toList(),
        phoneNo: json['phoneNo'] ?? '',
        address: json['address'] ?? '',
        dateOfBirth: json['dateOfBirth'] ?? '',
      );
}

class NurseProfileApiService {
  final String baseUrl;
  final Dio _dio;

  NurseProfileApiService(this.baseUrl) : _dio = Dio(BaseOptions(baseUrl: baseUrl));

  Future<NurseProfileResponse> getNurseProfile(String token) async {
    try {
      final res = await _dio.get(
        '/nurse/profile',
        options: Options(
          headers: {'Authorization': 'Bearer $token'},
        ),
      );
      return NurseProfileResponse.fromJson(res.data);
    } on DioException catch (e) {
      final data = e.response?.data;
      throw Exception('Failed to fetch nurse profile: $data');
    }
  }

  Future<NurseProfileResponse> updateNurseProfile(String token, NurseProfileRequest request) async {
    try {
      final res = await _dio.put(
        '/nurse/profile',
        data: request.toJson(),
        options: Options(
          headers: {'Authorization': 'Bearer $token', 'Content-Type': 'application/json'},
        ),
      );
      return NurseProfileResponse.fromJson(res.data);
    } on DioException catch (e) {
      final data = e.response?.data;
      throw Exception('Failed to update nurse profile: $data');
    }
  }
}