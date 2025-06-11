import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:elderly_care/domain/models/view_detail_viewmodel.dart';
import 'package:elderly_care/data/repository/view_detail_repository.dart';
import 'package:elderly_care/utils/auth_token.dart';
import 'package:elderly_care/data/repository/login_repository.dart';
import 'package:elderly_care/data/remote/response/view_detail_response.dart';
import 'package:elderly_care/data/remote/request/view_detail_request.dart';

// Register fake for ViewDetailRequest
class FakeViewDetailRequest extends Fake implements ViewDetailRequest {}

class MockViewDetailRepository extends Mock implements ViewDetailRepository {}
class MockSessionManager extends Mock implements SessionManager {}
class MockLoginRepository extends Mock implements LoginRepository {}

void main() {
  setUpAll(() {
    registerFallbackValue(FakeViewDetailRequest());
  });

  late MockViewDetailRepository repo;
  late MockSessionManager session;
  late MockLoginRepository loginRepo;
  late ViewDetailViewModel vm;

  setUp(() {
    repo = MockViewDetailRepository();
    session = MockSessionManager();
    loginRepo = MockLoginRepository();
    vm = ViewDetailViewModel(
      viewDetailRepository: repo,
      sessionManager: session,
      loginRepository: loginRepo,
    );
  });

  test('fetchElderDetail success', () async {
    when(() => session.fetchAuthToken()).thenAnswer((_) async => 'token');
    when(() => repo.getVisitDetails('token', 'elderId')).thenAnswer((_) async =>
      ViewDetailResponse(
        name: 'Elder',
        email: 'elder@email.com',
        heartRate: '70',
        bloodPressure: '120/80',
        bloodType: 'A+',
        description: 'desc',
        sugarLevel: '90',
      ));
    await vm.fetchElderDetail('elderId');
    expect(vm.state.name, 'Elder');
    expect(vm.state.email, 'elder@email.com');
    expect(vm.state.isLoading, false);
    expect(vm.state.error, isNull);
  });

  test('updateVisitDetails success', () async {
    when(() => session.fetchAuthToken()).thenAnswer((_) async => 'token');
    when(() => repo.updateVisitDetails(any(), any(), any())).thenAnswer((_) async =>
      ViewDetailResponse(
        name: 'Elder',
        email: 'elder@email.com',
        heartRate: '70',
        bloodPressure: '120/80',
        bloodType: 'A+',
        description: 'desc',
        sugarLevel: '90',
      ));
    when(() => repo.getVisitDetails(any(), any())).thenAnswer((_) async =>
      ViewDetailResponse(
        name: 'Elder',
        email: 'elder@email.com',
        heartRate: '70',
        bloodPressure: '120/80',
        bloodType: 'A+',
        description: 'desc',
        sugarLevel: '90',
      ));
    await vm.updateVisitDetails('elderId', '70', '120/80', '90');
    expect(vm.state.isSuccess, true);
    expect(vm.state.isLoading, false);
    expect(vm.state.error, isNull);
  });
}