import 'package:elderly_care/data/api/care_schedule_api_service.dart' as api;
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:elderly_care/domain/models/care_schedule_viewmodel.dart';
import 'package:elderly_care/data/repository/care_schedule_repository.dart';
import 'package:elderly_care/utils/auth_token.dart';

// Use the correct type for your ViewModel and repo!
class FakeAddScheduleRequest extends Fake implements api.AddScheduleRequest {}

class MockCareScheduleRepository extends Mock implements CareScheduleRepository {}
class MockSessionManager extends Mock implements SessionManager {}

void main() {
  setUpAll(() {
    registerFallbackValue(FakeAddScheduleRequest());
  });

  late MockCareScheduleRepository repo;
  late MockSessionManager session;
  late CareScheduleViewModel vm;

  setUp(() {
    repo = MockCareScheduleRepository();
    session = MockSessionManager();
    vm = CareScheduleViewModel(repository: repo, sessionManager: session);
  });

  test('handleSubmit success', () async {
    when(() => session.fetchAuthToken()).thenAnswer((_) async => 'token');
    // If your repository expects AddScheduleResponse from api_service,
    // import and use that. Otherwise, use a dummy object of the correct type.
    when(() => repo.addSchedule(any(), any()))
        .thenAnswer((_) async => api.AddScheduleResponse(message: "success"));
    vm.state = vm.state.copyWith(
      carePlan: 'Test Plan',
      frequency: 'Daily',
      startTime: '08:00',
      endTime: '17:00',
      postTo: 'All',
      userList: [],
    );
    await vm.handleSubmit();
    expect(vm.state.isLoading, false);
    expect(vm.state.isSuccess, true);
    expect(vm.state.error, isNull);
  });
}