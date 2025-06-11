abstract class SignUpEvent {}

class OnNameChange extends SignUpEvent {
  final String name;
  OnNameChange(this.name);
}

class OnEmailChange extends SignUpEvent {
  final String email;
  OnEmailChange(this.email);
}

class OnPassword extends SignUpEvent {
  final String password;
  OnPassword(this.password);
}

class OnConfirmPassword extends SignUpEvent {
  final String confirmPassword;
  OnConfirmPassword(this.confirmPassword);
}

class SignUpUser extends SignUpEvent {
  final String email;
  final String password;
  final String name;
  SignUpUser(this.email, this.password, this.name);
}

class SignUpNurse extends SignUpEvent {
  final String email;
  final String password;
  final String name;
  SignUpNurse(this.email, this.password, this.name);
}

class OnRoleChange extends SignUpEvent {
  final String role;
  OnRoleChange(this.role);
}

class OnSubmit extends SignUpEvent {}

class ClearSignupResults extends SignUpEvent {}