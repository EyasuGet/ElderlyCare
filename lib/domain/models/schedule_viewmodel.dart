import 'package:flutter_riverpod/legacy.dart';
import '../../data/repository/schedule_repository.dart';
import '../../utils/auth_token.dart';
import '../../application/state/schedule_state.dart';
import '../../application/providers/repository_providers.dart'; // adjust if needed

final scheduleViewModelProvider = StateNotifierProvider<ScheduleViewModel, ScheduleState>((ref) {
  final repository = ref.watch(scheduleRepositoryProvider);
  final sessionManager = ref.watch(sessionManagerProvider);
  return ScheduleViewModel(repository: repository, sessionManager: sessionManager);
});

class ScheduleViewModel extends StateNotifier<ScheduleState> {
  final ScheduleRepository repository;
  final SessionManager sessionManager;

  ScheduleViewModel({required this.repository, required this.sessionManager}) : super(ScheduleState());

  Future<void> onEvent(ScheduleEvent event) async {
    if (event == ScheduleEvent.fetchTasks) {
      await fetchTasks();
    }
  }

  Future<void> fetchTasks() async {
    state = state.copyWith(isLoading: true, error: null, tasks: []);
    try {
      final token = await sessionManager.fetchAuthToken();
      if (token == null) throw Exception("No auth token");
      final tasks = await repository.getTasks(token);
      state = state.copyWith(isLoading: false, tasks: tasks);
    } catch (e) {
      state = state.copyWith(isLoading: false, error: e.toString());
    }
  }
}