import 'package:flutter/material.dart';

class RoleToggleButton extends StatelessWidget {
  final String text;
  final bool selected;
  final VoidCallback onClick;

  const RoleToggleButton({
    Key? key,
    required this.text,
    required this.selected,
    required this.onClick,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final backgroundColor = selected ? const Color(0xFF1C6B66) : Colors.white;
    final textColor = selected ? Colors.white : Colors.black;
    return Container(
      width: 140,
      height: 48,
      decoration: BoxDecoration(
        color: backgroundColor,
        borderRadius: BorderRadius.circular(16),
      ),
      child: InkWell(
        borderRadius: BorderRadius.circular(16),
        onTap: onClick,
        child: Center(
          child: Text(
            text,
            style: TextStyle(
              color: textColor,
              fontWeight: FontWeight.w600,
            ),
          ),
        ),
      ),
    );
  }
}