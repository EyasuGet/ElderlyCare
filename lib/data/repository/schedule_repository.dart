import '../api/schedule_api_service.dart';
import '../remote/response/task_response.dart';

class ScheduleRepository {
  final ScheduleApiService apiService;
  ScheduleRepository(this.apiService);

  Future<List<TaskResponse>> getTasks(String token) async {
    final response = await apiService.getTasks(token);
    return response.tasks ?? [];
  }
}