import '../api/nurse_delete_api_service.dart';
import '../remote/response/nurse_delete_response.dart';

class NurseDeleteRepository {
  final NurseDeleteApiService apiService;
  NurseDeleteRepository(this.apiService);

  Future<NurseDeleteResponse> nurseDeleteUser(String token, String userId) async {
    return await apiService.nurseDeleteUser(token, userId);
  }
}