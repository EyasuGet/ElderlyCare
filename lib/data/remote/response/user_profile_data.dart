class UserProfileData {
  final String id;
  final String name;
  final String email;
  final String caretaker;
  final String gender;
  final String phoneNo;
  final String address;

  UserProfileData({
    required this.id,
    required this.name,
    required this.email,
    required this.caretaker,
    required this.gender,
    required this.phoneNo,
    required this.address,
  });

  factory UserProfileData.fromJson(Map<String, dynamic> json) => UserProfileData(
        id: json['_id'] ?? json['id'] ?? '',
        name: json['name'] ?? '',
        email: json['email'] ?? '',
        caretaker: json['caretaker'] ?? '',
        gender: json['gender'] ?? '',
        phoneNo: json['phoneNo'] ?? '',
        address: json['address'] ?? '',
      );
}