import 'package:flutter_riverpod/legacy.dart';
import '../../data/repository/nurse_delete_repository.dart';
import '../../utils/auth_token.dart';
import '../../application/state/nurse_delete_state.dart';
import '../../application/events/nurse_delete_event.dart';

class NurseDeleteViewModel extends StateNotifier<NurseDeleteState> {
  final NurseDeleteRepository nurseDeleteRepository;
  final SessionManager sessionManager;

  NurseDeleteViewModel({
    required this.nurseDeleteRepository,
    required this.sessionManager,
  }) : super(NurseDeleteState());

  Future<void> handleEvent(NurseDeleteEvent event) async {
    if (event is DeleteUser) {
      await _deleteUser(event.userId);
    }
  }

  Future<void> _deleteUser(String userId) async {
    state = NurseDeleteState(isLoading: true);
    try {
      final token = await sessionManager.fetchAuthToken();
      final response = await nurseDeleteRepository.nurseDeleteUser(token!, userId);
      state = NurseDeleteState(isLoading: false, successMessage: response.message);
      
    } catch (e) {
      state = NurseDeleteState(isLoading: false, errorMessage: e.toString());
    }
  }
}