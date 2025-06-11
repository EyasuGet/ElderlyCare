class ViewDetailState {
  final String? userId;
  final String? nurseName;
  final String? name;
  final String? email;
  final String? careTaker;
  final String? heartRate;
  final String? bloodPressure;
  final String? bloodType;
  final String? description;
  final String? sugarLevel;
  final bool isLoading;
  final bool isSuccess;
  final String? error;

  ViewDetailState({
    this.userId = "",
    this.nurseName = "",
    this.name = "",
    this.email = "",
    this.careTaker = "",
    this.heartRate = "",
    this.bloodPressure = "",
    this.bloodType = "",
    this.description = "",
    this.sugarLevel = "",
    this.isLoading = false,
    this.isSuccess = false,
    this.error,
  });

  ViewDetailState copyWith({
    String? userId,
    String? nurseName,
    String? name,
    String? email,
    String? careTaker,
    String? heartRate,
    String? bloodPressure,
    String? bloodType,
    String? description,
    String? sugarLevel,
    bool? isLoading,
    bool? isSuccess,
    String? error,
  }) {
    return ViewDetailState(
      userId: userId ?? this.userId,
      nurseName: nurseName ?? this.nurseName,
      name: name ?? this.name,
      email: email ?? this.email,
      careTaker: careTaker ?? this.careTaker,
      heartRate: heartRate ?? this.heartRate,
      bloodPressure: bloodPressure ?? this.bloodPressure,
      bloodType: bloodType ?? this.bloodType,
      description: description ?? this.description,
      sugarLevel: sugarLevel ?? this.sugarLevel,
      isLoading: isLoading ?? this.isLoading,
      isSuccess: isSuccess ?? this.isSuccess,
      error: error ?? this.error,
    );
  }
}