import 'package:elderly_care/data/api/care_schedule_api_service.dart';
import 'package:elderly_care/data/remote/request/add_schedule_request.dart' hide AddScheduleRequest;
import 'package:elderly_care/data/repository/care_schedule_repository.dart';
import 'package:elderly_care/application/providers/viewmodel_providers.dart';
import 'package:elderly_care/presentation/screens/care_schedule_screen.dart';
import 'package:elderly_care/application/state/care_schedule_state.dart';
import 'package:elderly_care/utils/auth_token.dart';
import 'package:elderly_care/domain/models/care_schedule_viewmodel.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';

// Dummy classes for required non-nullable parameters
class DummyCareScheduleRepository implements CareScheduleRepository {
  @override
  Future<AddScheduleResponse> addSchedule(String token, AddScheduleRequest schedule) {
    throw UnimplementedError();
  }

  @override
  Future<List<NurseListResponse>> fetchUserList(String token) {
    throw UnimplementedError();
  }

  @override
  @override
  CareScheduleApiService get api => throw UnimplementedError();
}
class DummySessionManager implements SessionManager {
  @override
  Future<void> clearSession() {
    // TODO: implement clearSession
    throw UnimplementedError();
  }

  @override
  Future<String?> fetchAuthToken() {
    // TODO: implement fetchAuthToken
    throw UnimplementedError();
  }

  @override
  Future<String?> fetchRole() {
    // TODO: implement fetchRole
    throw UnimplementedError();
  }

  @override
  Future<Map<String, dynamic>?> getUserInfoFromToken() {
    throw UnimplementedError();
  }

  @override
  Future<void> saveAuthToken(String token) {
    // TODO: implement saveAuthToken
    throw UnimplementedError();
  }

  @override
  Future<void> saveUserRole(String role) {
    // TODO: implement saveUserRole
    throw UnimplementedError();
  }
}

class DummyCareScheduleNotifier extends CareScheduleViewModel {
  DummyCareScheduleNotifier(CareScheduleState state)
      : super(repository: DummyCareScheduleRepository(), sessionManager: DummySessionManager()) {
    this.state = state;
  }
  @override
  Future<void> fetchUserList() async {}
  @override
  void handleEvent(event) {}
  @override
  void resetForm() {}
  @override
  void resetSuccess() {}
}

void main() {
  testWidgets('CareScheduleScreen shows all fields', (WidgetTester tester) async {
    final dummyNotifier = DummyCareScheduleNotifier(CareScheduleState());
    await tester.pumpWidget(
      ProviderScope(
        overrides: [
          careScheduleViewModelProvider.overrideWith((ref) => dummyNotifier),
        ],
        child: const MaterialApp(home: CareScheduleScreen()),
      ),
    );

    expect(find.text('Care Plan'), findsOneWidget);
    expect(find.text('Frequency'), findsOneWidget);
    expect(find.text('Start Time'), findsOneWidget);
    expect(find.text('End Time'), findsOneWidget);
    expect(find.text('Post To'), findsOneWidget);
    expect(find.widgetWithText(ElevatedButton, "Submit"), findsOneWidget);
  });

  testWidgets('CareScheduleScreen shows loading indicator', (WidgetTester tester) async {
    final dummyNotifier = DummyCareScheduleNotifier(CareScheduleState(isLoading: true));
    await tester.pumpWidget(
      ProviderScope(
        overrides: [
          careScheduleViewModelProvider.overrideWith((ref) => dummyNotifier),
        ],
        child: const MaterialApp(home: CareScheduleScreen()),
      ),
    );
    expect(find.byType(CircularProgressIndicator), findsOneWidget);
  });

  testWidgets('CareScheduleScreen shows error message', (WidgetTester tester) async {
    final dummyNotifier = DummyCareScheduleNotifier(CareScheduleState(error: 'Test error'));
    await tester.pumpWidget(
      ProviderScope(
        overrides: [
          careScheduleViewModelProvider.overrideWith((ref) => dummyNotifier),
        ],
        child: const MaterialApp(home: CareScheduleScreen()),
      ),
    );
    expect(find.text('Test error'), findsOneWidget);
  });

  testWidgets('CareScheduleScreen shows success snackbar', (WidgetTester tester) async {
    final dummyNotifier = DummyCareScheduleNotifier(CareScheduleState(isSuccess: true, postTo: 'All'));
    await tester.pumpWidget(
      ProviderScope(
        overrides: [
          careScheduleViewModelProvider.overrideWith((ref) => dummyNotifier),
        ],
        child: MaterialApp(home: CareScheduleScreen()),
      ),
    );
    // Let post frame callback run
    await tester.pump();
    expect(find.byType(SnackBar), findsOneWidget);
    expect(find.textContaining('Schedule added to all users!'), findsOneWidget);
  });
}