import '../api/login_api_service.dart';
import '../remote/request/login_request.dart';
import '../remote/response/login_response.dart';

class LoginRepository {
  final LoginApiService apiService;
  LoginRepository(this.apiService);

  Future<LoginResponse> loginUser(String email, String password) async {
    final loginRequest = LoginRequest(email: email, password: password);
    final response = await apiService.loginUser(loginRequest);
    if (response.token != null && response.token!.isNotEmpty) {
      return response;
    } else {
      throw Exception("Invalid login response: empty token");
    }
  }
}