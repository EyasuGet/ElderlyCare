import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:elderly_care/domain/models/schedule_viewmodel.dart';
import 'package:elderly_care/data/repository/schedule_repository.dart';
import 'package:elderly_care/utils/auth_token.dart';

class MockScheduleRepository extends Mock implements ScheduleRepository {}
class MockSessionManager extends Mock implements SessionManager {}

void main() {
  late MockScheduleRepository repo;
  late MockSessionManager session;
  late ScheduleViewModel vm;

  setUp(() {
    repo = MockScheduleRepository();
    session = MockSessionManager();
    vm = ScheduleViewModel(repository: repo, sessionManager: session);
  });

  test('fetchTasks success', () async {
    when(() => session.fetchAuthToken()).thenAnswer((_) async => 'token');
    when(() => repo.getTasks('token')).thenAnswer((_) async => []);
    await vm.fetchTasks();
    expect(vm.state.isLoading, false);
    expect(vm.state.tasks, isNotNull);
    expect(vm.state.error, isNull);
  });

  test('fetchTasks error', () async {
    when(() => session.fetchAuthToken()).thenThrow(Exception('fail'));
    await vm.fetchTasks();
    expect(vm.state.isLoading, false);
    expect(vm.state.error, contains('fail'));
  });
}