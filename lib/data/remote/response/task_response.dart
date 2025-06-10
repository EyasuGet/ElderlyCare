class TaskResponse {
  final String schedule;
  final String? frequency;
  final String? startTime;
  final String? endTime;

  TaskResponse({
    required this.schedule,
    this.frequency,
    this.startTime,
    this.endTime,
  });

  factory TaskResponse.fromJson(Map<String, dynamic> json) {
    return TaskResponse(
      schedule: json['schedule'] ?? '',
      frequency: json['frequency'],
      startTime: json['startTime'],
      endTime: json['endTime'],
    );
  }
}