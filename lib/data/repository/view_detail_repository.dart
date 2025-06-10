import '../api/view_detail_api_service.dart';
import '../remote/request/view_detail_request.dart';
import '../remote/response/view_detail_response.dart';

class ViewDetailRepository {
  final ViewDetailApiService apiService;
  ViewDetailRepository(this.apiService);

  Future<ViewDetailResponse> getVisitDetails(String token, String elderId) async {
    return await apiService.getVisitDetails(token, elderId);
  }

  Future<ViewDetailResponse> updateVisitDetails(
    String token,
    String elderId,
    ViewDetailRequest request
  ) async {
    return await apiService.updateVisitDetails(token, elderId, request);
  }
}