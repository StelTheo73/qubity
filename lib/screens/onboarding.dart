import 'package:flutter/material.dart';

import '../components/overlays/onboarding_overlay.dart';
import '../l10n/app_localizations.dart';
import 'base.dart';

class OnboardingScreen extends StatefulWidget {
  const OnboardingScreen({super.key});

  @override
  State<OnboardingScreen> createState() => _OnboardingScreenState();
}

class _OnboardingScreenState extends State<OnboardingScreen> {
  @override
  Widget build(BuildContext context) {
    return BaseScreen(
      title: AppLocalizations.of(context)!.onboarding,
      showBackButton: false,
      body: const Center(
        child: Padding(padding: EdgeInsets.all(25), child: OnboardingOverlay()),
      ),
    );
  }
}
