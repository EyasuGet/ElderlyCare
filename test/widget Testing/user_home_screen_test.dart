import 'package:elderly_care/data/remote/response/task_response.dart';
import 'package:elderly_care/data/repository/schedule_repository.dart';
import 'package:elderly_care/presentation/screens/user_task_screen.dart';
import 'package:elderly_care/utils/auth_token.dart';
import 'package:elderly_care/domain/models/schedule_viewmodel.dart';
import 'package:elderly_care/application/state/schedule_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

class MockScheduleRepository extends Mock implements ScheduleRepository {}
class MockSessionManager extends Mock implements SessionManager {}

class DummyScheduleNotifier extends ScheduleViewModel {
  DummyScheduleNotifier(ScheduleState initialState)
      : super(
          repository: MockScheduleRepository(),
          sessionManager: MockSessionManager(),
        ) {
    state = initialState;
  }
}

void main() {
  testWidgets('UserHomeScreen shows loading indicator', (WidgetTester tester) async {
    final dummyNotifier = DummyScheduleNotifier(ScheduleState(isLoading: true));
    await tester.pumpWidget(
      ProviderScope(
        overrides: [
          scheduleViewModelProvider.overrideWith((ref) => dummyNotifier),
        ],
        child: const MaterialApp(home: UserHomeScreen()),
      ),
    );
    expect(find.byType(CircularProgressIndicator), findsOneWidget);
  });

  testWidgets('UserHomeScreen shows error message', (WidgetTester tester) async {
    final dummyNotifier = DummyScheduleNotifier(ScheduleState(error: 'Something went wrong'));
    await tester.pumpWidget(
      ProviderScope(
        overrides: [
          scheduleViewModelProvider.overrideWith((ref) => dummyNotifier),
        ],
        child: const MaterialApp(home: UserHomeScreen()),
      ),
    );
    expect(find.textContaining('Error: Something went wrong'), findsOneWidget);
  });

  testWidgets('UserHomeScreen shows empty message', (WidgetTester tester) async {
    final dummyNotifier = DummyScheduleNotifier(ScheduleState(tasks: []));
    await tester.pumpWidget(
      ProviderScope(
        overrides: [
          scheduleViewModelProvider.overrideWith((ref) => dummyNotifier),
        ],
        child: const MaterialApp(home: UserHomeScreen()),
      ),
    );
    expect(find.text('No tasks available'), findsOneWidget);
  });

  testWidgets('UserHomeScreen shows a schedule task', (WidgetTester tester) async {
    final task = TaskResponse(
      schedule: 'Medication',
      frequency: 'Daily',
      startTime: '2025-06-10T09:00:00Z',
      endTime: '2025-06-10T17:00:00Z',
    );
    final dummyNotifier = DummyScheduleNotifier(ScheduleState(tasks: [task]));
    await tester.pumpWidget(
      ProviderScope(
        overrides: [
          scheduleViewModelProvider.overrideWith((ref) => dummyNotifier),
        ],
        child: const MaterialApp(home: UserHomeScreen()),
      ),
    );
    expect(find.text('Medication'), findsOneWidget);
    expect(find.text('Daily'), findsOneWidget);
    expect(find.text('2025-06-10'), findsNWidgets(2)); // start and end date
  });
}