class ViewDetailResponse {
  final String name;
  final String email;
  final String? heartRate;
  final String? bloodPressure;
  final String? bloodType;
  final String? description;
  final String? sugarLevel;

  ViewDetailResponse({
    required this.name,
    required this.email,
    this.heartRate,
    this.bloodPressure,
    this.bloodType,
    this.description,
    this.sugarLevel
  });

  factory ViewDetailResponse.fromJson(Map<String, dynamic> json) {
    return ViewDetailResponse(
      name: json['name'] ?? '',
      email: json['email'] ?? '',
      heartRate: json['heartRate'],
      bloodPressure: json['bloodPressure'],
      bloodType: json['bloodType'],
      description: json['description'],
      sugarLevel: json['sugarLevel']
    );
  }
}