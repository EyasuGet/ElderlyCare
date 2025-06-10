import 'package:dio/dio.dart';

import '../remote/response/nurse_list_response_wrapper.dart';
import '../remote/response/view_detail_response.dart';
import '../remote/response/nurse_delete_response.dart';

class NurseApiService {
  final String baseUrl;
  final Dio _dio;

  NurseApiService(this.baseUrl) : _dio = Dio(BaseOptions(baseUrl: baseUrl));

  Future<NurseListResponseWrapper> getUserList(String token) async {
    try {
      final response = await _dio.get(
        '/nurse',
        options: Options(
          headers: {'Authorization': 'Bearer $token'},
        ),
      );
      return NurseListResponseWrapper.fromJson(response.data);
    } on DioException catch (e) {
      final data = e.response?.data;
      throw Exception('Failed to fetch user list: $data');
    }
  }

  Future<List<ViewDetailResponse>> viewDetails(String userId, String token) async {
    try {
      final response = await _dio.get(
        '/nurse/user/$userId/details',
        options: Options(
          headers: {'Authorization': 'Bearer $token'},
        ),
      );
      final List<dynamic> data = response.data;
      return data.map((e) => ViewDetailResponse.fromJson(e)).toList();
    } on DioException catch (e) {
      final data = e.response?.data;
      throw Exception('Failed to fetch details: $data');
    }
  }

  Future<NurseDeleteResponse> nurseDeleteUser(String userId, String token) async {
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
      throw Exception('Failed to delete user: $data');
    }
  }
}