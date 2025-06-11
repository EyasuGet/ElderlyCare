import 'package:elderly_care/data/remote/response/user_profile_data.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:elderly_care/domain/models/user_profile_viewmodel.dart';
import 'package:elderly_care/data/repository/user_profile_repository.dart';
import 'package:elderly_care/utils/auth_token.dart';
import 'package:elderly_care/data/remote/response/user_profile_response.dart';
import 'package:elderly_care/data/remote/request/user_edit_profile_request.dart';

// --- Add this Fake for mocktail! ---
class FakeUserEditProfileRequest extends Fake implements UserEditProfileRequest {}

class MockUserProfileRepository extends Mock implements UserProfileRepository {}
class MockSessionManager extends Mock implements SessionManager {}

void main() {
  setUpAll(() {
    registerFallbackValue(FakeUserEditProfileRequest());
  });

  late MockUserProfileRepository repo;
  late MockSessionManager session;
  late UserProfileViewModel vm;

  setUp(() {
    repo = MockUserProfileRepository();
    session = MockSessionManager();
    vm = UserProfileViewModel(repository: repo, sessionManager: session);
  });

  test('fetchUserProfile success', () async {
    when(() => session.fetchAuthToken()).thenAnswer((_) async => 'token');
    when(() => repo.getUserProfile('token'))
        .thenAnswer((_) async => UserProfileResponse(
          data: UserProfileData(
            id: "12",
            name: 'Eyasu',
            gender: 'Male',
            phoneNo: '123',
            caretaker: 'John',
            address: 'Earth',
            email: 'eyasu@email.com',
          ), message: '',
        ));
    await vm.fetchUserProfile();
    expect(vm.state.fullName, 'Eyasu');
    expect(vm.state.gender, 'Male');
    expect(vm.state.phoneNumber, '123');
    expect(vm.state.caretaker, 'John');
    expect(vm.state.address, 'Earth');
    expect(vm.state.email, 'eyasu@email.com');
    expect(vm.state.isLoading, false);
    expect(vm.state.error, isNull);
  });

  test('fetchUserProfile error on missing token', () async {
    when(() => session.fetchAuthToken()).thenAnswer((_) async => null);
    await vm.fetchUserProfile();
    expect(vm.state.error, contains('Token not available'));
    expect(vm.state.isLoading, false);
  });

  test('updateProfile success', () async {
    when(() => session.fetchAuthToken()).thenAnswer((_) async => 'token');
    when(() => repo.updateUserProfile(any(), any())).thenAnswer((_) async => UserProfileResponse(
      data: UserProfileData(
        id: "12",
        name: 'Eyasu',
        gender: 'Male',
        phoneNo: '123',
        caretaker: 'John',
        address: 'Earth',
        email: 'eyasu@email.com',
      ),
      message: '',
    ));
    vm.state = vm.state.copyWith(
      fullName: 'Eyasu',
      gender: 'Male',
      phoneNumber: '123',
      caretaker: 'John',
      address: 'Earth',
      email: 'eyasu@email.com',
    );
    await vm.updateProfile();
    expect(vm.state.isSuccess, true);
    expect(vm.state.isLoading, false);
    expect(vm.state.error, isNull);
  });
}