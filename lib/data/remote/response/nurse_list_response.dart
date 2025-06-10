class NurseListResponse {
  final String id;
  final String nurseId;
  final String name;
  final String email;
  final String profileImg;
  final List<String> tasks;

  NurseListResponse({
    required this.nurseId,
    required this.id,
    required this.name,
    required this.email,
    required this.profileImg,
    required this.tasks,
  });

  factory NurseListResponse.fromJson(Map<String, dynamic> json) {
    return NurseListResponse(
      id: json['id'] ?? '',
      nurseId: json['_id'] ?? '',
      name: json['name'] ?? '', 
      email: json['email'] ?? '',
      profileImg: json['profileImg'] ?? '',
      tasks: (json['tasks'] as List<dynamic>?)
              ?.map((e) => e.toString())
              .toList() ?? [],
    );
  }
}

