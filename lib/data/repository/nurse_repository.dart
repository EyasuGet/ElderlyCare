import '../api/nurse_api_service.dart';
import '../remote/response/nurse_list_response.dart';

class NurseRepository {
  final NurseApiService apiService;
  NurseRepository(this.apiService);

  Future<List<NurseListResponse>> getUserList(String token) async {
    final wrapper = await apiService.getUserList(token);
    return wrapper.users;
  }
}