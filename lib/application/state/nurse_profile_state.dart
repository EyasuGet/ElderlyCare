class NurseProfileState {
  final String name;
  final String email;
  final String phoneNumber;
  final String userName;
  final String yearsOfExperience;
  final bool isLoading;
  final String? error;
  final bool isSuccess;

  NurseProfileState({
    this.name = "",
    this.email = "",
    this.phoneNumber = "",
    this.userName = "",
    this.yearsOfExperience = "",
    this.isLoading = false,
    this.error,
    this.isSuccess = false,
  });

  NurseProfileState copyWith({
    String? name,
    String? email,
    String? phoneNumber,
    String? userName,
    String? yearsOfExperience,
    bool? isLoading,
    String? error,
    bool? isSuccess,
  }) {
    return NurseProfileState(
      name: name ?? this.name,
      email: email ?? this.email,
      phoneNumber: phoneNumber ?? this.phoneNumber,
      userName: userName ?? this.userName,
      yearsOfExperience: yearsOfExperience ?? this.yearsOfExperience,
      isLoading: isLoading ?? this.isLoading,
      error: error,
      isSuccess: isSuccess ?? this.isSuccess,
    );
  }
}