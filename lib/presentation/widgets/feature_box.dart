import 'package:flutter/material.dart';
import '../../theme/colors.dart';

class FeatureBox extends StatelessWidget {
  final String imageAsset;
  final String label;

  const FeatureBox({
    Key? key,
    required this.imageAsset,
    required this.label,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 120,
      height: 120,
      decoration: BoxDecoration(
        color: backgroundBoxColor,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: primaryColor, width: 1),
      ),
      padding: const EdgeInsets.all(16),
      child: LayoutBuilder(
        builder: (context, constraints) {
          return Column(
            mainAxisAlignment: MainAxisAlignment.center,
            mainAxisSize: MainAxisSize.min, // Prevent overflow
            children: [
              Expanded(
                child: Image.asset(
                  imageAsset,
                  width: 95,
                  height: 95,
                  fit: BoxFit.contain,
                ),
              ),
              const SizedBox(height: 5),
              Flexible(
                child: Text(
                  label,
                  style: const TextStyle(
                    color: textColor,
                    fontWeight: FontWeight.bold,
                    fontSize: 16,
                  ),
                  textAlign: TextAlign.center,
                  overflow: TextOverflow.ellipsis,
                  maxLines: 2,
                ),
              ),
            ],
          );
        },
      ),
    );
  }
}