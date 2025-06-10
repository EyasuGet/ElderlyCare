import 'package:dio/dio.dart';
import '../remote/request/login_request.dart';
import '../remote/response/login_response.dart';

class LoginApiService {
  final String baseUrl;
  final Dio _dio;

  LoginApiService(this.baseUrl) : _dio = Dio(BaseOptions(baseUrl: baseUrl));

  Future<LoginResponse> loginUser(LoginRequest request) async {
    try {
      final response = await _dio.post(
        '/auth/login',
        data: request.toJson(),
        options: Options(
          headers: {'Content-Type': 'application/json'},
        ),
      );
      return LoginResponse.fromJson(response.data);
    } on DioException catch (e) {
      final statusCode = e.response?.statusCode;
      final data = e.response?.data;
      throw Exception('Login failed: $statusCode $data');
    }
  }
}