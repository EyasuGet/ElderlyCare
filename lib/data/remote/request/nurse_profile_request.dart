class NurseProfileRequest {
  final String name;
  final String email;
  final String phoneNo;
  final String userName;

  NurseProfileRequest({
    required this.name,
    required this.email,
    required this.phoneNo,
    required this.userName,
  });

  Map<String, dynamic> toJson() => {
    'name': name,
    'email': email,
    'phoneNo': phoneNo,
    'userName': userName,
  };
}