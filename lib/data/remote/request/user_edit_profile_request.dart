class UserEditProfileRequest {
  final String name;
  final String? email;
  final String caretaker;
  final String gender;
  final String phoneNo;
  final String address;

  UserEditProfileRequest({
    required this.name,
    this.email,
    required this.caretaker,
    required this.gender,
    required this.phoneNo,
    required this.address,
  });

  Map<String, dynamic> toJson() => {
        'name': name,
        'email': email,
        'caretaker': caretaker,
        'gender': gender,
        'phoneNo': phoneNo,
        'address': address,
      };
}