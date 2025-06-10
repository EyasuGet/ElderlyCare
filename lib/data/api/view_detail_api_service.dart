import 'package:dio/dio.dart';
import '../remote/response/view_detail_response.dart';
import '../remote/request/view_detail_request.dart';

class ViewDetailApiService {
  final String baseUrl;
  final Dio _dio;

  ViewDetailApiService(this.baseUrl) : _dio = Dio(BaseOptions(baseUrl: baseUrl));

  Future<ViewDetailResponse> getVisitDetails(String token, String elderId) async {
    try {
      final response = await _dio.get(
        '/nurse/user/$elderId/details',
        options: Options(
          headers: {'Authorization': 'Bearer $token'},
        ),
      );
      return ViewDetailResponse.fromJson(response.data);
    } on DioException catch (e) {
      final data = e.response?.data;
      throw Exception("Get visit details failed: $data");
    }
  }

  Future<ViewDetailResponse> updateVisitDetails(
      String token, String elderId, ViewDetailRequest request) async {
    try {
      final response = await _dio.put(
        '/nurse/user/$elderId/details',
        data: request.toJson(),
        options: Options(
          headers: {
            'Authorization': 'Bearer $token',
            'Content-Type': 'application/json',
          },
        ),
      );
      return ViewDetailResponse.fromJson(response.data);
    } on DioException catch (e) {
      final data = e.response?.data;
      throw Exception("Update visit details failed: $data");
    }
  }
}