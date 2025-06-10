abstract class NurseProfileEvent {}

class OnNameChange extends NurseProfileEvent {
  final String name;
  OnNameChange(this.name);
}

class OnEmailChange extends NurseProfileEvent {
  final String email;
  OnEmailChange(this.email);
}

class OnPhoneNumberChange extends NurseProfileEvent {
  final String phoneNumber;
  OnPhoneNumberChange(this.phoneNumber);
}

class OnUserNameChange extends NurseProfileEvent {
  final String userName;
  OnUserNameChange(this.userName);
}

class OnYearsOfExperienceChange extends NurseProfileEvent {
  final String yearsOfExperience;
  OnYearsOfExperienceChange(this.yearsOfExperience);
}

class OnSubmit extends NurseProfileEvent {}

class FetchNurseProfile extends NurseProfileEvent {}