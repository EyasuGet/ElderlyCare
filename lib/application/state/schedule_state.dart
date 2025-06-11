import '../../data/remote/response/task_response.dart';

class ScheduleState {
  final bool isLoading;
  final List<TaskResponse>? tasks;
  final String? error;

  ScheduleState({this.isLoading = false, this.tasks, this.error});

  ScheduleState copyWith({
    bool? isLoading,
    List<TaskResponse>? tasks,
    String? error,
  }) {
    return ScheduleState(
      isLoading: isLoading ?? this.isLoading,
      tasks: tasks ?? this.tasks,
      error: error,
    );
  }
}

enum ScheduleEvent {
  fetchTasks,
}