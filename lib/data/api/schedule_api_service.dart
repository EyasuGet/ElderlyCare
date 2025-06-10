import 'package:dio/dio.dart';
import '../remote/response/tasks_response.dart';

class ScheduleApiService {
  final String baseUrl;
  final Dio _dio;

  ScheduleApiService(this.baseUrl) : _dio = Dio(BaseOptions(baseUrl: baseUrl));

  Future<TasksResponse> getTasks(String token) async {
    try {
      final response = await _dio.get(
        '/user/tasks',
        options: Options(
          headers: {
            'Authorization': 'Bearer $token',
            'Content-Type': 'application/json',
          },
        ),
      );
      return TasksResponse.fromJson(response.data);
    } on DioException catch (e) {
      final data = e.response?.data;
      throw Exception('Failed to fetch tasks: $data');
    }
  }
}