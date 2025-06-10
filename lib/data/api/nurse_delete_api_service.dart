import 'package:dio/dio.dart';
import '../remote/response/nurse_delete_response.dart';

class NurseDeleteApiService {
  final String baseUrl;
  final Dio _dio;

  NurseDeleteApiService(this.baseUrl) : _dio = Dio(BaseOptions(baseUrl: baseUrl));

  Future<NurseDeleteResponse> nurseDeleteUser(String token, String userId) async {
    try {
      final response = await _dio.delete(
        '/nurse/user/$userId/details/delete',
        options: Options(
          headers: {'Authorization': 'Bearer $token'},
        ),
      );
      return NurseDeleteResponse.fromJson(response.data);
    } on DioException catch (e) {
      final data = e.response?.data;
      throw Exception("Delete user failed: $data");
    }
  }
}