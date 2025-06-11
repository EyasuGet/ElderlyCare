import 'package:elderly_care/data/api/care_schedule_api_service.dart';
import 'package:flutter_riverpod/legacy.dart';
import '../../application/state/care_schedule_state.dart';
import '../../application/events/care_schedule_event.dart';
import '../../data/repository/care_schedule_repository.dart';
import '../../utils/auth_token.dart';

class CareScheduleViewModel extends StateNotifier<CareScheduleState> {
  final CareScheduleRepository repository;
  final SessionManager sessionManager;

  CareScheduleViewModel({
    required this.repository,
    required this.sessionManager,
  }) : super(CareScheduleState());

  void handleEvent(CareScheduleEvent event) {
    if (event is CareScheduleEventOnCarePlanChange) {
      state = state.copyWith(carePlan: event.carePlan);
    } else if (event is CareScheduleEventOnFrequencyChange) {
      state = state.copyWith(frequency: event.frequency);
    } else if (event is CareScheduleEventOnStartTimeChange) {
      state = state.copyWith(startTime: event.startTime);
    } else if (event is CareScheduleEventOnEndTimeChange) {
      state = state.copyWith(endTime: event.endTime);
    } else if (event is CareScheduleEventOnPostToChange) {
      state = state.copyWith(postTo: event.postTo);
    } else if (event is CareScheduleEventOnSubmit) {
      handleSubmit();
    }
  }

  void resetForm() {
    state = CareScheduleState(
      userList: state.userList,
    );
  }

  Future<void> handleSubmit() async {
    state = state.copyWith(isLoading: true, error: null, isSuccess: false);
    try {
      final token = await sessionManager.fetchAuthToken();
      List<String> assignedTo;
      if (state.postTo == "All") {
        assignedTo = state.userList.map((e) => e.id).toList();
      } else {
        assignedTo = [state.postTo];
      }
      final req = AddScheduleRequest(
        schedule: state.carePlan,
        frequency: state.frequency,
        startTime: state.startTime,
        endTime: state.endTime,
        assignedTo: assignedTo,
      );
      await repository.addSchedule(token!, req);
      state = state.copyWith(isLoading: false, isSuccess: true, error: null);
    } catch (e) {
      state = state.copyWith(isLoading: false, error: e.toString());
    }
  }

  Future<void> fetchUserList() async {
    try {
      final token = await sessionManager.fetchAuthToken();
      final users = await repository.fetchUserList(token!);
      state = state.copyWith(
        userList: users.map((e) => UserItem(id: e.id, email: e.email)).toList(),
      );
    } catch (e) {
      state = state.copyWith(error: "Failed to fetch users: $e");
    }
  }

  void resetSuccess() {
    state = state.copyWith(isSuccess: false);
  }
}