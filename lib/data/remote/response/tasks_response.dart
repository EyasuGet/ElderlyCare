import 'task_response.dart';

class TasksResponse {
  final List<TaskResponse>? tasks;

  TasksResponse({this.tasks});

  factory TasksResponse.fromJson(Map<String, dynamic> json) {
    return TasksResponse(
      tasks: (json['tasks'] as List?)
          ?.map((e) => TaskResponse.fromJson(e))
          .toList(),
    );
  }
}