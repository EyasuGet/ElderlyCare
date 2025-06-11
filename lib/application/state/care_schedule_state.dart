class CareScheduleState {
  final String carePlan;
  final String frequency;
  final String startTime;
  final String endTime;
  final String postTo; // This holds the selected id or 'All'
  final List<UserItem> userList; // Contains id and email
  final bool isLoading;
  final String? error;
  final bool isSuccess;

  CareScheduleState({
    this.carePlan = "",
    this.frequency = "",
    this.startTime = "",
    this.endTime = "",
    this.postTo = "",
    this.userList = const [],
    this.isLoading = false,
    this.error,
    this.isSuccess = false,
  });

  CareScheduleState copyWith({
    String? carePlan,
    String? frequency,
    String? startTime,
    String? endTime,
    String? postTo,
    List<UserItem>? userList,
    bool? isLoading,
    String? error,
    bool? isSuccess,
  }) {
    return CareScheduleState(
      carePlan: carePlan ?? this.carePlan,
      frequency: frequency ?? this.frequency,
      startTime: startTime ?? this.startTime,
      endTime: endTime ?? this.endTime,
      postTo: postTo ?? this.postTo,
      userList: userList ?? this.userList,
      isLoading: isLoading ?? this.isLoading,
      error: error,
      isSuccess: isSuccess ?? this.isSuccess,
    );
  }
}

class UserItem {
  final String id;
  final String email;
  UserItem({required this.id, required this.email});
}