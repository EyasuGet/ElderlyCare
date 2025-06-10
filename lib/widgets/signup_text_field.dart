import 'package:flutter/material.dart';

class SignUpTextField extends StatefulWidget {
  final String label;
  final String value;
  final bool isPassword;
  final ValueChanged<String> onChanged;

  const SignUpTextField({
    Key? key,
    required this.label,
    required this.value,
    this.isPassword = false,
    required this.onChanged,
  }) : super(key: key);

  @override
  State<SignUpTextField> createState() => _SignUpTextFieldState();
}

class _SignUpTextFieldState extends State<SignUpTextField> {
  late TextEditingController _controller;

  @override
  void initState() {
    super.initState();
    _controller = TextEditingController(text: widget.value);
  }

  @override
  void didUpdateWidget(SignUpTextField oldWidget) {
    super.didUpdateWidget(oldWidget);
    // Only update text if it actually changed to avoid cursor jump!
    if (widget.value != _controller.text) {
      _controller.value = TextEditingValue(
        text: widget.value,
        selection: TextSelection.collapsed(offset: widget.value.length),
      );
    }
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return TextField(
      obscureText: widget.isPassword,
      decoration: InputDecoration(
        labelText: widget.label,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(16),
        ),
        fillColor: Colors.white,
        filled: true,
      ),
      onChanged: widget.onChanged,
      controller: _controller,
    );
  }
}