import 'package:dio/dio.dart';

class AddScheduleRequest {
  final String schedule;
  final String frequency;
  final String startTime;
  final String endTime;
  final List<String> assignedTo;

  AddScheduleRequest({
    required this.schedule,
    required this.frequency,
    required this.startTime,
    required this.endTime,
    required this.assignedTo,
  });

  Map<String, dynamic> toJson() => {
        'schedule': schedule,
        'frequency': frequency,
        'startTime': startTime,
        'endTime': endTime,
        'assignedTo': assignedTo,
      };
}

class AddScheduleResponse {
  final String message;

  AddScheduleResponse({required this.message});

  factory AddScheduleResponse.fromJson(Map<String, dynamic> json) =>
      AddScheduleResponse(message: json['message'] ?? "");
}

class NurseListResponse {
  final String id;
  final String email;

  NurseListResponse({required this.id, required this.email});

  factory NurseListResponse.fromJson(Map<String, dynamic> json) =>
      NurseListResponse(
        id: json['_id'] ?? json['id'] ?? "",
        email: json['email'] ?? "",
      );
}

class CareScheduleApiService {
  final String baseUrl;
  final Dio _dio;

  CareScheduleApiService(this.baseUrl)
      : _dio = Dio(BaseOptions(baseUrl: baseUrl));

  Future<AddScheduleResponse> addSchedule(
      String token, AddScheduleRequest req) async {
    try {
      final response = await _dio.post(
        '/nurse/addTask',
        data: req.toJson(),
        options: Options(
          headers: {
            'Authorization': 'Bearer $token',
            'Content-Type': 'application/json',
          },
        ),
      );
      return AddScheduleResponse.fromJson(response.data);
    } on DioException catch (e) {
      final data = e.response?.data;
      throw Exception('Error adding schedule: $data');
    }
  }

  Future<List<NurseListResponse>> fetchUserList(String token) async {
    try {
      final response = await _dio.get(
        '/nurse',
        options: Options(
          headers: {
            'Authorization': 'Bearer $token',
          },
        ),
      );
      final body = response.data;
      final users = body['users'] as List;
      return users.map((j) => NurseListResponse.fromJson(j)).toList();
    } on DioException catch (e) {
      final data = e.response?.data;
      throw Exception('Failed to fetch user list: $data');
    }
  }
}