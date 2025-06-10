import 'nurse_list_response.dart';

class NurseListResponseWrapper {
  final List<NurseListResponse> users;

  NurseListResponseWrapper({required this.users});

  factory NurseListResponseWrapper.fromJson(Map<String, dynamic> json) {
    return NurseListResponseWrapper(
      users: (json['users'] as List<dynamic>)
          .map((e) => NurseListResponse.fromJson(e))
          .toList(),
    );
  }
}