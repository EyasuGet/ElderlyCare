class ViewDetailRequest {
  final String heartRate;
  final String bloodPressure;
  final String sugarLevel;

  ViewDetailRequest(this.heartRate, this.bloodPressure, this.sugarLevel);

  Map<String, dynamic> toJson() => {
    'heartRate': heartRate,
    'bloodPressure': bloodPressure,
    'sugarLevel': sugarLevel,
  };
}