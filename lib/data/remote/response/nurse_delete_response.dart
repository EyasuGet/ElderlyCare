class NurseDeleteResponse {
  final String message;

  NurseDeleteResponse({required this.message});

  factory NurseDeleteResponse.fromJson(Map<String, dynamic> json) {
    return NurseDeleteResponse(
      message: json['message'] ?? '',
    );
  }
}