import 'package:elderly_care/presentation/screens/login_screen.dart';
import 'package:elderly_care/application/state/login_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:elderly_care/data/repository/login_repository.dart';
import 'package:elderly_care/utils/auth_token.dart';
import 'package:elderly_care/domain/models/login_viewmodel.dart';
import 'package:elderly_care/application/events/login_event.dart';

class MockLoginRepository extends Mock implements LoginRepository {}
class MockSessionManager extends Mock implements SessionManager {}

class DummyLoginNotifier extends LoginViewModel {
  DummyLoginNotifier(LoginState state)
      : super(repository: MockLoginRepository(), sessionManager: MockSessionManager()) {
    this.state = state;
  }
  final List<Object> events = [];
  @override
  void handleEvent(LoginEvent event) {
    events.add(event);
  }
}

void main() {
  testWidgets('LoginScreen renders and reacts to input', (WidgetTester tester) async {
    final dummyNotifier = DummyLoginNotifier(LoginState());

    await tester.pumpWidget(
      ProviderScope(
        overrides: [
          loginViewModelProvider.overrideWith((ref) => dummyNotifier),
        ],
        child: MaterialApp(
          home: LoginScreen(
            onSignUpClick: () {},
            onForgotPassword: () {},
            onLoginSuccess: (_) {},
          ),
        ),
      ),
    );

    expect(find.text('Welcome Back'), findsOneWidget);

    // Enter email and password
    await tester.enterText(find.byWidgetPredicate((w) => w is TextField && (w.decoration?.hintText == "Email")), 'test@user.com');
    await tester.enterText(find.byWidgetPredicate((w) => w is TextField && (w.decoration?.hintText == "Password")), 'pass123');

    // Tap Log in
    await tester.tap(find.widgetWithText(ElevatedButton, "Log in"));
    await tester.pumpAndSettle();

    expect(dummyNotifier.events.any((e) => e is OnSubmit), isTrue);
  });

  testWidgets('LoginScreen shows error message', (WidgetTester tester) async {
    final dummyNotifier = DummyLoginNotifier(LoginState(error: "Login failed"));

    await tester.pumpWidget(
      ProviderScope(
        overrides: [
          loginViewModelProvider.overrideWith((ref) => dummyNotifier),
        ],
        child: MaterialApp(
          home: LoginScreen(
            onSignUpClick: () {},
            onForgotPassword: () {},
            onLoginSuccess: (_) {},
          ),
        ),
      ),
    );

    // Let UI update
    await tester.pump();

    expect(find.text("Login failed"), findsOneWidget);
  });
}