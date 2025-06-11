class SignUpState {
  final String name;
  final String email;
  final String password;
  final String confirmPassword;
  final String role;
  final bool isLoading;
  final bool isSignedUp;
  final bool isSuccess;
  final String? error;

  SignUpState({
    this.name = '',
    this.email = '',
    this.password = '',
    this.confirmPassword = '',
    this.role = 'USER',
    this.isLoading = false,
    this.isSignedUp = false,
    this.isSuccess = false,
    this.error,
  });

  SignUpState copyWith({
    String? name,
    String? email,
    String? password,
    String? confirmPassword,
    String? role,
    bool? isLoading,
    bool? isSignedUp,
    bool? isSuccess,
    String? error,
  }) {
    return SignUpState(
      name: name ?? this.name,
      email: email ?? this.email,
      password: password ?? this.password,
      confirmPassword: confirmPassword ?? this.confirmPassword,
      role: role ?? this.role,
      isLoading: isLoading ?? this.isLoading,
      isSignedUp: isSignedUp ?? this.isSignedUp,
      isSuccess: isSuccess ?? this.isSuccess,
      error: error,
    );
  }
}