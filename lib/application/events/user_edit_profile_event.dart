abstract class UserEditProfileEvent {}

class UpdateFullName extends UserEditProfileEvent {
  final String fullName;
  UpdateFullName(this.fullName);
}

class UpdateGender extends UserEditProfileEvent {
  final String gender;
  UpdateGender(this.gender);
}

class UpdatePhoneNumber extends UserEditProfileEvent {
  final String phoneNumber;
  UpdatePhoneNumber(this.phoneNumber);
}

class UpdateCaretaker extends UserEditProfileEvent {
  final String caretaker;
  UpdateCaretaker(this.caretaker);
}

class UpdateAddress extends UserEditProfileEvent {
  final String address;
  UpdateAddress(this.address);
}

class UpdateEmail extends UserEditProfileEvent {
  final String email;
  UpdateEmail(this.email);
}

class SubmitProfile extends UserEditProfileEvent {}

class LoadProfile extends UserEditProfileEvent {}