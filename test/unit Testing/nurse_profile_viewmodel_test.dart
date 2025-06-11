import 'package:elderly_care/data/api/nurse_profile_api_service.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:elderly_care/domain/models/nurse_profile_viewmodel.dart';
import 'package:elderly_care/data/repository/nurse_profile_repository.dart';
import 'package:elderly_care/utils/auth_token.dart';
import 'package:elderly_care/data/remote/response/nurse_profile_response.dart';
import 'package:elderly_care/data/remote/request/nurse_profile_request.dart';

// --- Add this Fake for mocktail! ---
class FakeNurseProfileRequest extends Fake implements NurseProfileRequest {}

class MockNurseProfileRepository extends Mock implements NurseProfileRepository {}
class MockSessionManager extends Mock implements SessionManager {}

void main() {
  setUpAll(() {
    registerFallbackValue(FakeNurseProfileRequest());
  });

  late MockNurseProfileRepository repo;
  late MockSessionManager session;
  late NurseProfileViewModel vm;

  setUp(() {
    repo = MockNurseProfileRepository();
    session = MockSessionManager();
    vm = NurseProfileViewModel(repository: repo, sessionManager: session);
  });

  test('fetchNurseProfile success', () async {
    when(() => session.fetchAuthToken()).thenAnswer((_) async => 'token');
    when(() => repo.getNurseProfile('token'))
        .thenAnswer((_) async => NurseProfileResponse(
          data: NurseProfileData(
            id: '1',
            name: 'Nurse',
            email: 'nurse@email.com',
            phoneNo: '911',
            assignedElders: const [],
            address: '123 Main St',
            dateOfBirth: "12/2/2000",
          ), message: '',
        ));
    await vm.fetchNurseProfile();
    expect(vm.state.name, 'Nurse');
    expect(vm.state.email, 'nurse@email.com');
    expect(vm.state.phoneNumber, '911');
    expect(vm.state.isLoading, false);
    expect(vm.state.error, isNull);
  });

  test('updateProfile success', () async {
    when(() => session.fetchAuthToken()).thenAnswer((_) async => 'token');
    when(() => repo.updateNurseProfile(any(), any())).thenAnswer((_) async => NurseProfileResponse(
      data: NurseProfileData(
        id: '1',
        name: 'Nurse',
        email: 'nurse@email.com',
        phoneNo: '911',
        assignedElders: const [],
        address: '123 Main St',
        dateOfBirth: "12/2/2000",
      ),
      message: '',
    ));
    vm.state = vm.state.copyWith(
      name: 'Nurse',
      email: 'nurse@email.com',
      phoneNumber: '911',
      userName: '@nurse',
    );
    await vm.updateProfile();
    expect(vm.state.isSuccess, true);
    expect(vm.state.isLoading, false);
    expect(vm.state.error, isNull);
  });
}