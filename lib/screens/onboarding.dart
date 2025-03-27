import 'package:flutter/material.dart';

import '../components/button/page_button.dart';
import '../components/overlays/onboarding_overlay.dart';
import '../constants/routes.dart';
import 'base.dart';

class OnboardingScreen extends StatefulWidget {
  const OnboardingScreen({super.key});

  @override
  State<OnboardingScreen> createState() => _OnboardingScreenState();
}

class _OnboardingScreenState extends State<OnboardingScreen> {
  @override
  Widget build(BuildContext context) {
    return const BaseScreen(
      title: 'Onboarding',
      showBackButton: false,
      body: Center(
        child: Padding(
          padding: EdgeInsets.all(25),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[OnboardingOverlay()],
          ),
        ),
      ),
    );
  }
}
