import 'package:dio/dio.dart';
import 'package:elderly_care/data/api/signup_api_service.dart';
import '../remote/request/signup_request.dart';
import '../remote/response/signup_response.dart';
import '../constants/api_constants.dart';

class SignUpRepository {
  final SignUpApiService apiService;

  SignUpRepository(this.apiService);

  Future<SignUpResponse> signUpUser(String email, String password, String name) async {
    final request = SignUpRequest(
      email: email,
      password: password,
      name: name,
      role: 'USER',
    );
    try {
      final response = await Dio().post(
        '$baseUrl/auth/user/signup',
        data: request.toJson(),
        options: Options(
          headers: {'Content-Type': 'application/json'},
        ),
      );
      return SignUpResponse.fromJson(response.data);
    } on DioException catch (e) {
      final data = e.response?.data;
      throw Exception('Sign up failed: $data');
    }
  }

  Future<SignUpResponse> signUpNurse(String email, String password, String name) async {
    final request = SignUpRequest(
      email: email,
      password: password,
      name: name,
      role: 'NURSE',
    );
    try {
      final response = await Dio().post(
        '$baseUrl/nurse/signup',
        data: request.toJson(),
        options: Options(
          headers: {'Content-Type': 'application/json'},
        ),
      );
      return SignUpResponse.fromJson(response.data);
    } on DioException catch (e) {
      final data = e.response?.data;
      throw Exception('Sign up failed: $data');
    }
  }
}