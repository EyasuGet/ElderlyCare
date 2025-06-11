abstract class ViewDetailEvent {}

class FetchElderDetail extends ViewDetailEvent {
  final String elderId;
  FetchElderDetail(this.elderId);
}
class OnHeartRateChange extends ViewDetailEvent {
  final String heartRate;
  OnHeartRateChange(this.heartRate);
}
class OnBloodPressureChange extends ViewDetailEvent {
  final String bloodPressure;
  OnBloodPressureChange(this.bloodPressure);
}
class OnSugarLevelChange extends ViewDetailEvent {
  final String sugarLevel;
  OnSugarLevelChange(this.sugarLevel);
}
class UpdateUserDetail extends ViewDetailEvent {
  final String elderId;
  final String heartRate;
  final String bloodPressure;
  final String sugarLevel;
  UpdateUserDetail({
    required this.elderId,
    required this.heartRate,
    required this.bloodPressure,
    required this.sugarLevel,
  });
}