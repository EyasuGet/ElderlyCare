import 'package:flutter_riverpod/legacy.dart';
import '../../data/repository/nurse_repository.dart';
import '../../utils/auth_token.dart';
import '../../application/state/nurse_list_state.dart';
import '../../application/events/nurse_list_event.dart';

class NurseListViewModel extends StateNotifier<NurseListState> {
  final NurseRepository repository;
  final SessionManager sessionManager;

  NurseListViewModel({required this.repository, required this.sessionManager})
      : super(NurseListState()) {
    handleEvent(FetchElderList());
  }

  void handleEvent(NurseListEvent event) {
    if (event is FetchElderList) {
      fetchElderList();
    }
  }

  Future<void> fetchElderList() async {
    state = state.copyWith(isLoading: true, error: null, elderList: []);
    try {
      final token = await sessionManager.fetchAuthToken();
      if (token == null) throw Exception("No token found");
      final list = await repository.getUserList(token);
      state = state.copyWith(isLoading: false, elderList: list);
    } catch (e) {
      state = state.copyWith(isLoading: false, error: e.toString());
    }
  }
}