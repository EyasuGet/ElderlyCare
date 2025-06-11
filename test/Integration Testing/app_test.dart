import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:integration_test/integration_test.dart';
import 'package:elderly_care/main.dart' as app;

void main() {
  IntegrationTestWidgetsFlutterBinding.ensureInitialized();

  testWidgets('Signup and Login flow - success and validation', (WidgetTester tester) async {
    app.main();
    await tester.pumpAndSettle();

    // LANDING PAGE
    final getStartedButton = find.byKey(const Key('getStartedButton'));
    expect(getStartedButton, findsOneWidget);
    await tester.ensureVisible(getStartedButton);
    await tester.tap(getStartedButton);
    await tester.pumpAndSettle();

    // LOGIN PAGE
    final signUpButton = find.byKey(const Key('signUpButton'));
    expect(signUpButton, findsOneWidget);
    await tester.ensureVisible(signUpButton);
    await tester.tap(signUpButton);
    await tester.pumpAndSettle();

    // SIGNUP PAGE
    expect(find.text("Sign Up"), findsOneWidget);

    // Select "User" role (if needed)
    final userRoleButton = find.byKey(const Key('userRoleButton'));
    if (tester.any(userRoleButton)) {
      await tester.ensureVisible(userRoleButton);
      await tester.tap(userRoleButton);
      await tester.pumpAndSettle();
    }

    // Fill full name
    await tester.enterText(find.byKey(const Key('signupNameField')), "Test User");
    await tester.pumpAndSettle();

    // Fill email
    final uniqueEmail = 'testuser${DateTime.now().millisecondsSinceEpoch}@example.com';
    await tester.enterText(find.byKey(const Key('signupEmailField')), uniqueEmail);
    await tester.pumpAndSettle();

    // Fill password
    await tester.enterText(find.byKey(const Key('signupPasswordField')), "password123");
    await tester.pumpAndSettle();

    // Fill confirm password
    await tester.enterText(find.byKey(const Key('signupConfirmPasswordField')), "password123");
    await tester.pumpAndSettle();

    // Tap Create Account
    final createAccountButton = find.byKey(const Key('createAccountButton'));
    await tester.ensureVisible(createAccountButton);
    await tester.tap(createAccountButton);
    await tester.pumpAndSettle();

    // Check for success message or error
    final signUpSuccessFinder = find.textContaining("Sign up successful");
    if (!tester.any(signUpSuccessFinder)) {
      expect(find.textContaining("already"), findsNothing, reason: "Signup failed for new user");
    } else {
      expect(signUpSuccessFinder, findsOneWidget);
    }

    // Tap "Login" to go back to Login page
    final loginLink = find.byKey(const Key('loginLink'));
    await tester.ensureVisible(loginLink);
    await tester.tap(loginLink);
    await tester.pumpAndSettle();

    // LOGIN PAGE AGAIN
    await tester.enterText(find.byKey(const Key('loginEmailField')), "testuser@example.com");
    await tester.pumpAndSettle();

    await tester.enterText(find.byKey(const Key('loginPasswordField')), "password123");
    await tester.pumpAndSettle();

    final loginButton = find.byKey(const Key('loginButton'));
    await tester.ensureVisible(loginButton);
    await tester.tap(loginButton);
    await tester.pumpAndSettle(const Duration(seconds: 2));

  });
}