class UserEditProfileState {
  final String fullName;
  final String gender;
  final String phoneNumber;
  final String caretaker;
  final String address;
  final String email;
  final bool isLoading;
  final String? error;
  final bool isSuccess;

  UserEditProfileState({
    this.fullName = "",
    this.gender = "",
    this.phoneNumber = "",
    this.caretaker = "",
    this.address = "",
    this.email = "",
    this.isLoading = false,
    this.error,
    this.isSuccess = false,
  });

  UserEditProfileState copyWith({
    String? fullName,
    String? gender,
    String? phoneNumber,
    String? caretaker,
    String? address,
    String? email,
    bool? isLoading,
    String? error,
    bool? isSuccess,
  }) {
    return UserEditProfileState(
      fullName: fullName ?? this.fullName,
      gender: gender ?? this.gender,
      phoneNumber: phoneNumber ?? this.phoneNumber,
      caretaker: caretaker ?? this.caretaker,
      address: address ?? this.address,
      email: email ?? this.email,
      isLoading: isLoading ?? this.isLoading,
      error: error,
      isSuccess: isSuccess ?? this.isSuccess,
    );
  }
}