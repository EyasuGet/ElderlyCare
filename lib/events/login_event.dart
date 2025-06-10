abstract class LoginEvent {}

class OnEmailChange extends LoginEvent {
  final String email;
  OnEmailChange(this.email);
}

class OnPasswordChange extends LoginEvent {
  final String password;
  OnPasswordChange(this.password);
}

class OnSubmit extends LoginEvent {}

class ClearLoginResults extends LoginEvent {}

class LogoutEvent extends LoginEvent {}