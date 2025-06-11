import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../domain/models/login_viewmodel.dart';
import '../../application/events/login_event.dart';

class LoginScreen extends ConsumerStatefulWidget {
  final VoidCallback onSignUpClick;
  final VoidCallback onForgotPassword;
  final Function(String role) onLoginSuccess;

  const LoginScreen({
    Key? key,
    required this.onSignUpClick,
    required this.onForgotPassword,
    required this.onLoginSuccess,
  }) : super(key: key);

  @override
  ConsumerState<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends ConsumerState<LoginScreen> {
  late TextEditingController _emailController;
  late TextEditingController _passwordController;
  bool _controllersInitialized = false;

  @override
  void initState() {
    super.initState();
    Future.microtask(() {
      ref.read(loginViewModelProvider.notifier).handleEvent(ClearLoginResults());
    });
    _emailController = TextEditingController();
    _passwordController = TextEditingController();
  }

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  void _updateControllersIfNeeded(String email, String password) {
    if (!_controllersInitialized || _emailController.text != email) {
      _emailController.text = email;
    }
    if (!_controllersInitialized || _passwordController.text != password) {
      _passwordController.text = password;
    }
    _controllersInitialized = true;
  }

  @override
  Widget build(BuildContext context) {
    final loginState = ref.watch(loginViewModelProvider);
    final loginViewModel = ref.read(loginViewModelProvider.notifier);

    _updateControllersIfNeeded(loginState.email, loginState.password);

    if (loginState.isSuccess) {
      WidgetsBinding.instance.addPostFrameCallback((_) {
        widget.onLoginSuccess(loginState.role);
      });
    }

    return Scaffold(
      backgroundColor: const Color(0xFFCAE7E5),
      body: SingleChildScrollView(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 40),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            const SizedBox(height: 30),
            Image.asset(
              'lib/assets/images/logo.png',
              width: 120,
              height: 120,
            ),
            const SizedBox(height: 16),
            const Text(
              "Welcome Back",
              style: TextStyle(
                fontSize: 32,
                fontWeight: FontWeight.bold,
                color: Color(0xFF1D6A6E),
              ),
            ),
            const SizedBox(height: 12),
            Text(
              "Welcome back! Please enter your details.",
              style: TextStyle(
                fontSize: 14,
                fontWeight: FontWeight.bold,
                color: const Color(0xFF1D6A6E),
              ),
            ),
            const SizedBox(height: 28),
            _LoginTextField(
              key: const Key('loginEmailField'),
              label: "Enter your email",
              placeholder: "Email",
              controller: _emailController,
              isPassword: false,
              onValueChange: (val) =>
                  loginViewModel.handleEvent(OnEmailChange(val)),
            ),
            _LoginTextField(
              key: const Key('loginPasswordField'),
              label: "Enter your password",
              placeholder: "Password",
              controller: _passwordController,
              isPassword: true,
              onValueChange: (val) =>
                  loginViewModel.handleEvent(OnPasswordChange(val)),
            ),
            const SizedBox(height: 8),
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                GestureDetector(
                  onTap: widget.onForgotPassword,
                  child: const Text(
                    "Forgot Password?",
                    style: TextStyle(
                      color: Color(0xFF1D6A6E),
                      fontSize: 14,
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 40),
            if (loginState.isLoading)
              const CircularProgressIndicator(
                color: Color(0xFF1D6A6E),
              )
            else
              SizedBox(
                width: double.infinity,
                height: 60,
                child: ElevatedButton(
                  key: const Key('loginButton'),
                  onPressed: () {
                    if (_emailController.text.isNotEmpty &&
                        _passwordController.text.isNotEmpty) {
                      loginViewModel.handleEvent(OnSubmit());
                    } else {
                      loginViewModel.handleEvent(ClearLoginResults());
                    }
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color(0xFF1D6A6E),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(25),
                    ),
                  ),
                  child: const Text(
                    "Log in",
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ),
            const SizedBox(height: 18),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Text(
                  "Don’t have an account? ",
                  style: TextStyle(color: Color(0xFF1D6A6E)),
                ),
                GestureDetector(
                  key: const Key('signUpButton'),
                  onTap: widget.onSignUpClick,
                  child: const Text(
                    "Sign up",
                    style: TextStyle(
                      color: Color(0xFF1D6A6E),
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ],
            ),
            if (loginState.error != null)
              Padding(
                padding: const EdgeInsets.only(top: 16.0),
                child: Text(
                  loginState.error!,
                  style: const TextStyle(color: Colors.red, fontWeight: FontWeight.bold),
                ),
              ),
          ],
        ),
      ),
    );
  }
}

class _LoginTextField extends StatelessWidget {
  final String label;
  final String placeholder;
  final TextEditingController controller;
  final bool isPassword;
  final ValueChanged<String> onValueChange;

  const _LoginTextField({
    Key? key,
    required this.label,
    required this.placeholder,
    required this.controller,
    this.isPassword = false,
    required this.onValueChange,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: const TextStyle(
            color: Color(0xFF1D6A6E),
            fontWeight: FontWeight.w500,
            fontSize: 14,
          ),
        ),
        const SizedBox(height: 4),
        TextField(
          controller: controller,
          obscureText: isPassword,
          decoration: InputDecoration(
            hintText: placeholder,
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(16),
            ),
            filled: true,
            fillColor: Colors.white,
          ),
          onChanged: onValueChange,
        ),
        const SizedBox(height: 12),
      ],
    );
  }
}