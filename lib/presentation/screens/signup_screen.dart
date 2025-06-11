import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../domain/models/signup_viewmodel.dart';
import '../../application/events/signup_event.dart';
import '../widgets/role_toggle_button.dart';
import '../widgets/signup_text_field.dart';

class SignUpScreen extends ConsumerWidget {
  final VoidCallback onLoginClick;

  const SignUpScreen({Key? key, required this.onLoginClick}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final state = ref.watch(signUpViewModelProvider);
    final viewModel = ref.read(signUpViewModelProvider.notifier);

    final backgroundColor = const Color(0xFFCAE7E5);
    final primaryColor = const Color(0xFF1C6B66);
    final white = Colors.white;

    return Scaffold(
      backgroundColor: backgroundColor,
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            const SizedBox(height: 24),
            Text(
              "Sign Up",
              style: TextStyle(
                fontSize: 28,
                fontWeight: FontWeight.bold,
                color: primaryColor,
              ),
            ),
            const SizedBox(height: 24),
            // Role Selector
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                RoleToggleButton(
                  key: const Key('userRoleButton'),
                  text: "User",
                  selected: state.role == "USER",
                  onClick: () => viewModel.handleEvent(OnRoleChange("USER")),
                ),
                RoleToggleButton(
                  key: const Key('nurseRoleButton'),
                  text: "Nurse",
                  selected: state.role == "NURSE",
                  onClick: () => viewModel.handleEvent(OnRoleChange("NURSE")),
                ),
              ],
            ),
            const SizedBox(height: 16),
            Align(
              alignment: Alignment.centerLeft,
              child: Text(
                "Full Name*",
                style: TextStyle(
                  color: Colors.black,
                  fontSize: 12,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            SignUpTextField(
              key: const Key('signupNameField'),
              label: "Enter Your Name",
              value: state.name,
              onChanged: (val) => viewModel.handleEvent(OnNameChange(val)),
            ),
            Align(
              alignment: Alignment.centerLeft,
              child: Text(
                "Email*",
                style: TextStyle(
                  color: Colors.black,
                  fontSize: 12,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            SignUpTextField(
              key: const Key('signupEmailField'),
              label: "Enter Your Email",
              value: state.email,
              onChanged: (val) => viewModel.handleEvent(OnEmailChange(val)),
            ),
            Align(
              alignment: Alignment.centerLeft,
              child: Text(
                "Password*",
                style: TextStyle(
                  color: Colors.black,
                  fontSize: 12,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            SignUpTextField(
              key: const Key('signupPasswordField'),
              label: "Enter your password",
              value: state.password,
              isPassword: true,
              onChanged: (val) => viewModel.handleEvent(OnPassword(val)),
            ),
            Align(
              alignment: Alignment.centerLeft,
              child: Text(
                "Confirm Password*",
                style: TextStyle(
                  color: Colors.black,
                  fontSize: 12,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            SignUpTextField(
              key: const Key('signupConfirmPasswordField'),
              label: "ReEnter Your password",
              value: state.confirmPassword,
              isPassword: true,
              onChanged: (val) => viewModel.handleEvent(OnConfirmPassword(val)),
            ),
            const SizedBox(height: 24),
            SizedBox(
              width: double.infinity,
              height: 56,
              child: ElevatedButton(
                key: const Key('createAccountButton'),
                style: ElevatedButton.styleFrom(
                  backgroundColor: primaryColor,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(16),
                  ),
                ),
                onPressed: () {
                  if (state.password == state.confirmPassword) {
                    viewModel.handleEvent(OnSubmit());
                  } else {
                    viewModel.handleEvent(ClearSignupResults());
                  }
                },
                child: state.isLoading
                    ? CircularProgressIndicator(color: white)
                    : Text(
                        "Create Account",
                        style: TextStyle(
                          color: white,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
              ),
            ),
            const SizedBox(height: 16),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Text("Already have an account? "),
                GestureDetector(
                  key: const Key('loginLink'),
                  onTap: () {
                    viewModel.handleEvent(ClearSignupResults());
                    onLoginClick();
                  },
                  child: Text(
                    "Login",
                    style: TextStyle(
                      color: primaryColor,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 16),
            if (state.isSignedUp)
              Text(
                "Sign up successful! please Login",
                style: TextStyle(
                  color: Colors.green,
                  fontSize: 14,
                  fontWeight: FontWeight.bold,
                ),
              ),
            if (state.error != null)
              Text(
                state.error!,
                style: TextStyle(
                  color: Colors.red,
                  fontSize: 14,
                  fontWeight: FontWeight.bold,
                ),
              ),
          ],
        ),
      ),
    );
  }
}