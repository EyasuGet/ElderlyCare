import 'package:elderly_care/data/remote/response/login_response.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:elderly_care/domain/models/login_viewmodel.dart';
import 'package:elderly_care/application/events/login_event.dart';
import 'package:elderly_care/data/repository/login_repository.dart';
import 'package:elderly_care/utils/auth_token.dart';

class MockLoginRepository extends Mock implements LoginRepository {}
class MockSessionManager extends Mock implements SessionManager {}

void main() {
  late MockLoginRepository repo;
  late MockSessionManager session;
  late LoginViewModel vm;

  setUp(() {
    repo = MockLoginRepository();
    session = MockSessionManager();
    vm = LoginViewModel(repository: repo, sessionManager: session);
  });

  test('OnEmailChange updates email', () {
    vm.handleEvent(OnEmailChange('test@example.com'));
    expect(vm.state.email, 'test@example.com');
  });

  test('handleLogin success', () async {
    when(() => repo.loginUser(any(), any())).thenAnswer((_) async => 
      LoginResponse(token: 'token', role: 'USER')
    );
    when(() => session.saveAuthToken(any())).thenAnswer((_) async {});
    when(() => session.saveUserRole(any())).thenAnswer((_) async {});
    await vm.handleLogin('test@example.com', 'pass');
    expect(vm.state.isSuccess, true);
    expect(vm.state.role, 'USER');
    expect(vm.state.isLoading, false);
    expect(vm.state.error, isNull);
  });

  test('handleLogin failure', () async {
    when(() => repo.loginUser(any(), any())).thenThrow(Exception('fail'));
    await vm.handleLogin('test@example.com', 'pass');
    expect(vm.state.isSuccess, false);
    expect(vm.state.error, contains('fail'));
  });

  test('logout clears session and sets logoutSuccess', () async {
    when(() => session.clearSession()).thenAnswer((_) async {});
    await vm.logout();
    expect(vm.state.logoutSuccess, true);
  });
}