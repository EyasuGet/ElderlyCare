import 'package:elderly_care/presentation/screens/signup_screen.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:elderly_care/domain/models/signup_viewmodel.dart';
import 'package:elderly_care/application/events/signup_event.dart';
import 'package:elderly_care/application/state/signup_state.dart';
import 'package:elderly_care/data/repository/signup_repository.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:mocktail/mocktail.dart';
import 'package:flutter/material.dart';

// Mock repository
class MockSignUpRepository extends Mock implements SignUpRepository {}

class DummyNotifier extends SignUpViewModel {
  DummyNotifier() : super(repository: MockSignUpRepository());
  final List<Object> events = [];
  @override
  void handleEvent(SignUpEvent event) {
    events.add(event);
  }
}

void main() {
  testWidgets('SignUpScreen renders and reacts to input', (WidgetTester tester) async {

    final dummyNotifier = DummyNotifier();

    await tester.pumpWidget(
      ProviderScope(
        overrides: [
          signUpViewModelProvider.overrideWith((ref) => dummyNotifier),
        ],
        child: MaterialApp(
          home: SignUpScreen(onLoginClick: () {}),
        ),
      ),
    );

    // Check for title
    expect(find.text('Sign Up'), findsOneWidget);

    // Enter name, email, password, confirm password
    await tester.enterText(find.byWidgetPredicate((w) => w is TextField && (w.decoration?.labelText == "Enter Your Name")), 'Eyasu');
    await tester.enterText(find.byWidgetPredicate((w) => w is TextField && (w.decoration?.labelText == "Enter Your Email")), 'e@e.com');
    await tester.enterText(find.byWidgetPredicate((w) => w is TextField && (w.decoration?.labelText == "Enter your password")), 'pass123');
    await tester.enterText(find.byWidgetPredicate((w) => w is TextField && (w.decoration?.labelText == "ReEnter Your password")), 'pass123');

    // Tap Create Account
    await tester.tap(find.widgetWithText(ElevatedButton, "Create Account"));
    await tester.pumpAndSettle();

    // Check that our dummy notifier received OnSubmit
    expect(dummyNotifier.events.any((e) => e is OnSubmit), isTrue);
  });

  testWidgets('SignUpScreen shows error message', (WidgetTester tester) async {
    // Set up a dummy notifier with error state
    final dummyNotifier = DummyNotifier();
    dummyNotifier.state = SignUpState(error: "Signup failed");

    await tester.pumpWidget(
      ProviderScope(
        overrides: [
          signUpViewModelProvider.overrideWith((ref) => dummyNotifier),
        ],
        child: MaterialApp(
          home: SignUpScreen(onLoginClick: () {}),
        ),
      ),
    );

    expect(find.text("Signup failed"), findsOneWidget);
  });

  testWidgets('SignUpScreen shows success message', (WidgetTester tester) async {
    final dummyNotifier = DummyNotifier();
    dummyNotifier.state = SignUpState(isSignedUp: true);

    await tester.pumpWidget(
      ProviderScope(
        overrides: [
          signUpViewModelProvider.overrideWith((ref) => dummyNotifier),
        ],
        child: MaterialApp(
          home: SignUpScreen(onLoginClick: () {}),
        ),
      ),
    );

    expect(find.textContaining("Sign up successful"), findsOneWidget);
  });
}