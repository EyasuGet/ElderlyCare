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