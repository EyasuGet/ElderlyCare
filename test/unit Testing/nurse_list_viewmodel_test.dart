import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:elderly_care/domain/models/nurse_list_viewmodel.dart';
import 'package:elderly_care/data/repository/nurse_repository.dart';
import 'package:elderly_care/utils/auth_token.dart';

class MockNurseRepository extends Mock implements NurseRepository {}
class MockSessionManager extends Mock implements SessionManager {}

void main() {
  // No custom types to register for this test file!

  late MockNurseRepository repo;
  late MockSessionManager session;
  late NurseListViewModel vm;

  setUp(() {
    repo = MockNurseRepository();
    session = MockSessionManager();
    vm = NurseListViewModel(repository: repo, sessionManager: session);
  });

  test('fetchElderList success', () async {
    when(() => session.fetchAuthToken()).thenAnswer((_) async => 'token');
    when(() => repo.getUserList('token')).thenAnswer((_) async => [
      // Mock your user list objects as needed
    ]);
    await vm.fetchElderList();
    expect(vm.state.isLoading, false);
    expect(vm.state.elderList, isNotNull);
    expect(vm.state.error, isNull);
  });

  test('fetchElderList error', () async {
    when(() => session.fetchAuthToken()).thenThrow(Exception('fail'));
    await vm.fetchElderList();
    expect(vm.state.isLoading, false);
    expect(vm.state.error, contains('fail'));
  });
}