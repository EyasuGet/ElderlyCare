import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:elderly_care/domain/models/signup_viewmodel.dart';
import 'package:elderly_care/application/events/signup_event.dart';
import 'package:elderly_care/data/repository/signup_repository.dart';
import 'package:elderly_care/data/remote/response/signup_response.dart';

class MockSignUpRepository extends Mock implements SignUpRepository {}

void main() {
  late MockSignUpRepository repo;
  late SignUpViewModel vm;

  setUp(() {
    repo = MockSignUpRepository();
    vm = SignUpViewModel(repository: repo);
  });

  test('OnNameChange updates name', () {
    vm.handleEvent(OnNameChange('Eyasu'));
    expect(vm.state.name, 'Eyasu');
  });

  test('signUpUser success', () async {
    // Return a dummy SignUpResponse from the mock
    when(() => repo.signUpUser(any(), any(), any()))
      .thenAnswer((_) async => SignUpResponse(
        message: "Signed up!",
        // fill any other required fields if present
      ));
    vm.handleEvent(OnRoleChange('USER'));
    vm.handleEvent(OnNameChange('Eyasu'));
    vm.handleEvent(OnEmailChange('e@e.com'));
    vm.handleEvent(OnPassword('pass'));
    vm.handleEvent(OnConfirmPassword('pass'));
    await vm.signUpUser('e@e.com', 'pass', 'Eyasu');
    expect(vm.state.isSuccess, true);
    expect(vm.state.isSignedUp, true);
    expect(vm.state.isLoading, false);
    expect(vm.state.error, isNull);
  });

  test('signUpUser failure', () async {
    when(() => repo.signUpUser(any(), any(), any()))
      .thenThrow(Exception('fail'));
    await vm.signUpUser('e@e.com', 'pass', 'Eyasu');
    expect(vm.state.isSuccess, false);
    expect(vm.state.error, contains('fail'));
  });
}