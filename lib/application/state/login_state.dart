  class LoginState {
    final String email;
    final String password;
    final bool isLoading;
    final String? error;
    final bool isSuccess;
    final bool logoutSuccess;
    final bool loginSuccess;
    final String role;

    LoginState({
      this.email = '',
      this.password = '',
      this.isLoading = false,
      this.error,
      this.isSuccess = false,
      this.logoutSuccess = false,
      this.loginSuccess = false,
      this.role = '',
    });

    static LoginState initial() {
      return LoginState(
        // Set default values for all fields here
        email: '',
        password: '',
        isLoading: false,
        isSuccess: false,
        error: null,
        role: '',
        logoutSuccess: false,
      );
    }

    LoginState copyWith({
      String? email,
      String? password,
      bool? isLoading,
      String? error,
      bool? isSuccess,
      bool? logoutSuccess,
      bool? loginSuccess,
      String? role,
    }) {
      return LoginState(
        email: email ?? this.email,
        password: password ?? this.password,
        isLoading: isLoading ?? this.isLoading,
        error: error,
        isSuccess: isSuccess ?? this.isSuccess,
        logoutSuccess: logoutSuccess ?? this.logoutSuccess,
        loginSuccess: loginSuccess ?? this.loginSuccess,
        role: role ?? this.role,
      );
    }
  }