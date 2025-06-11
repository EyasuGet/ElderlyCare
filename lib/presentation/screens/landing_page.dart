import 'package:flutter/material.dart';
import '../../theme/colors.dart';
import '../widgets/feature_box.dart';

class LandingPage extends StatelessWidget {
  final VoidCallback onGetStarted;

  const LandingPage({super.key, required this.onGetStarted});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: LayoutBuilder(
          builder: (context, constraints) {
            final isSmall = constraints.maxHeight < 600;

            return SingleChildScrollView(
              padding: const EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  const SizedBox(height: 15),
                  Image.asset(
                    'lib/assets/images/logo.png',
                    width: isSmall ? 120 : 210,
                    height: isSmall ? 120 : 210,
                  ),
                  const SizedBox(height: 10),
                  Text(
                    "Nurses by your side, anytime.",
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontSize: isSmall ? 16 : 22,
                      fontWeight: FontWeight.bold,
                      color: textColor.withAlpha((0.8 * 255).toInt()),
                    ),
                  ),
                  const SizedBox(height: 40),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: const [
                      FeatureBox(
                        imageAsset: 'lib/assets/images/supportive.png',
                        label: 'Supportive',
                      ),
                      SizedBox(width: 20),
                      FeatureBox(
                        imageAsset: 'lib/assets/images/reliable.png',
                        label: 'Reliable',
                      ),
                    ],
                  ),
                  const SizedBox(height: 30),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: const [
                      FeatureBox(
                        imageAsset: 'lib/assets/images/easy.png',
                        label: 'Easy',
                      ),
                      SizedBox(width: 20),
                      FeatureBox(
                        imageAsset: 'lib/assets/images/emphatethic.png',
                        label: 'Empathetic',
                      ),
                    ],
                  ),
                  const SizedBox(height: 50),
                  SizedBox(
                    width: 300,
                    height: 70,
                    child: ElevatedButton(
                      key: const Key('getStartedButton'),
                      onPressed: onGetStarted,
                      style: ElevatedButton.styleFrom(
                        backgroundColor: primaryColor,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(50),
                        ),
                      ),
                      child: const Text(
                        "Get Started",
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(height: 20),
                ],
              ),
            );
          },
        ),
      ),
    );
  }
}