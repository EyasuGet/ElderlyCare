import 'package:elderly_care/application/events/nurse_delete_event.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:elderly_care/domain/models/nurse_delete_viewmodel.dart';
import 'package:elderly_care/data/repository/nurse_delete_repository.dart';
import 'package:elderly_care/utils/auth_token.dart';
import 'package:elderly_care/data/remote/response/nurse_delete_response.dart';

class MockNurseDeleteRepository extends Mock implements NurseDeleteRepository {}
class MockSessionManager extends Mock implements SessionManager {}

void main() {
  late MockNurseDeleteRepository repo;
  late MockSessionManager session;
  late NurseDeleteViewModel vm;

  setUp(() {
    repo = MockNurseDeleteRepository();
    session = MockSessionManager();
    vm = NurseDeleteViewModel(nurseDeleteRepository: repo, sessionManager: session);
  });

  test('delete user success', () async {
    when(() => session.fetchAuthToken()).thenAnswer((_) async => 'token');
    when(() => repo.nurseDeleteUser('token', 'userId')).thenAnswer((_) async =>
      NurseDeleteResponse(message: "Deleted"));
    await vm.handleEvent(DeleteUser('userId'));
    expect(vm.state.isLoading, false);
    expect(vm.state.successMessage, "Deleted");
    expect(vm.state.errorMessage, isNull);
  });

  test('delete user failure', () async {
    when(() => session.fetchAuthToken()).thenAnswer((_) async => 'token');
    when(() => repo.nurseDeleteUser('token', 'userId')).thenThrow(Exception('fail'));
    await vm.handleEvent(DeleteUser('userId'));
    expect(vm.state.isLoading, false);
    expect(vm.state.successMessage, isNull);
    expect(vm.state.errorMessage, contains('fail'));
  });
}