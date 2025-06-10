class SignUpRequest {
  final String email;
  final String password;
  final String name;
  final String role;

  SignUpRequest({
    required this.email,
    required this.password,
    required this.name,
    required this.role,
  });

  Map<String, dynamic> toJson() => {
        'email': email,
        'password': password,
        'name': name,
        'role': role,
      };
}