import 'package:dio/dio.dart';
import '../remote/request/signup_request.dart';
import '../remote/response/signup_response.dart';

class SignUpApiService {
  final String baseUrl;
  final Dio _dio;

  SignUpApiService(this.baseUrl) : _dio = Dio(BaseOptions(baseUrl: baseUrl));

  // POST to auth/user/signup for regular users
  Future<SignUpResponse> signUpUser(SignUpRequest request) async {
    try {
      final response = await _dio.post(
        '/auth/user/signup',
        data: request.toJson(),
        options: Options(
          headers: {'Content-Type': 'application/json'},
        ),
      );
      return SignUpResponse.fromJson(response.data);
    } on DioException catch (e) {
      final statusCode = e.response?.statusCode;
      final data = e.response?.data;
      throw Exception('Sign up failed: $statusCode $data');
    }
  }

  // POST to nurse/signup for nurses
  Future<SignUpResponse> signUpNurse(SignUpRequest request) async {
    try {
      final response = await _dio.post(
        '/nurse/signup',
        data: request.toJson(),
        options: Options(
          headers: {'Content-Type': 'application/json'},
        ),
      );
      return SignUpResponse.fromJson(response.data);
    } on DioException catch (e) {
      final statusCode = e.response?.statusCode;
      final data = e.response?.data;
      throw Exception('Sign up failed: $statusCode $data');
    }
  }
}