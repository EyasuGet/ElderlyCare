class SignUpResponse {
  final String? message;

  SignUpResponse({this.message});

  factory SignUpResponse.fromJson(Map<String, dynamic> json) {
    return SignUpResponse(
      message: json['message'],
    );
  }
}