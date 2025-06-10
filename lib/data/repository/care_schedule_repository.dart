import '../api/care_schedule_api_service.dart';

class CareScheduleRepository {
  final CareScheduleApiService api;

  CareScheduleRepository(this.api);

  Future<AddScheduleResponse> addSchedule(String token, AddScheduleRequest req) {
    return api.addSchedule(token, req);
  }

  Future<List<NurseListResponse>> fetchUserList(String token) {
    return api.fetchUserList(token);
  }
}