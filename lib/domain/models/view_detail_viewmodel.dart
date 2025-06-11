import 'package:flutter_riverpod/legacy.dart';
import '../../data/repository/view_detail_repository.dart';
import '../../utils/auth_token.dart';
import '../../application/state/view_detail_state.dart';
import '../../application/events/view_detail_event.dart';
import '../../data/repository/login_repository.dart';
import '../../data/remote/request/view_detail_request.dart';

class ViewDetailViewModel extends StateNotifier<ViewDetailState> {
  final ViewDetailRepository viewDetailRepository;
  final SessionManager sessionManager;
  final LoginRepository loginRepository;

  ViewDetailViewModel({
    required this.viewDetailRepository,
    required this.sessionManager,
    required this.loginRepository,
  }) : super(ViewDetailState());

  Future<void> fetchUserAndNurseInfo() async {
    final userInfo = await sessionManager.getUserInfoFromToken();
    final userId = userInfo != null && userInfo['id'] != null ? userInfo['id'].toString() : "Unknown";
    final nurseName = userInfo != null && userInfo['name'] != null ? userInfo['name'].toString() : "Unknown";
    state = state.copyWith(userId: userId, nurseName: nurseName);
  }

  void handleEvent(ViewDetailEvent event) {
    if (event is FetchElderDetail) {
      fetchElderDetail(event.elderId);
    } else if (event is OnHeartRateChange) {
      state = state.copyWith(heartRate: event.heartRate);
    } else if (event is OnSugarLevelChange) {
      state = state.copyWith(sugarLevel: event.sugarLevel);
    } else if (event is OnBloodPressureChange) {
      state = state.copyWith(bloodPressure: event.bloodPressure);
    } else if (event is UpdateUserDetail) {
      updateVisitDetails(
        event.elderId,
        event.heartRate,
        event.bloodPressure,
        event.sugarLevel,
      );
    }
  }

  Future<void> fetchElderDetail(String elderId) async {
    state = state.copyWith(isLoading: true, error: null);
    try {
      final token = await sessionManager.fetchAuthToken();
      final elderDetail = await viewDetailRepository.getVisitDetails(token!, elderId);
      state = state.copyWith(
        isLoading: false,
        name: elderDetail.name,
        email: elderDetail.email,
        careTaker: "Aster Chane",
        heartRate: elderDetail.heartRate ?? "75",
        bloodPressure: elderDetail.bloodPressure ?? "120/80",
        bloodType: elderDetail.bloodType ?? "B+",
        description: elderDetail.description ?? "Hypertension\nDiabetes Mellitus\nDementia",
        sugarLevel: elderDetail.sugarLevel ?? "73",
      );
    } catch (e) {
      state = state.copyWith(isLoading: false, error: e.toString());
    }
  }

  Future<void> updateVisitDetails(
    String elderId, String? heartRate, String? bloodPressure, String? sugarLevel) async {
    final hr = heartRate ?? "";
    final bp = bloodPressure ?? "";
    final sl = sugarLevel ?? "";
    state = state.copyWith(isLoading: true, error: null, isSuccess: false);
    try {
      final token = await sessionManager.fetchAuthToken();
      await viewDetailRepository.updateVisitDetails(
        token!,
        elderId,
        ViewDetailRequest(hr, bp, sl),
      );
      await fetchElderDetail(elderId);
      state = state.copyWith(isLoading: false, isSuccess: true);
    } catch (e) {
      state = state.copyWith(isLoading: false, error: e.toString());
    }
  }
}