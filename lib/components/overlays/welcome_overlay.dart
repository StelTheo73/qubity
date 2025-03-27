import 'package:flutter/material.dart';

import '../../constants/colors.dart';
import '../../constants/routes.dart';
import '../../l10n/app_localizations.dart';
import '../../store/onboarding_notifier.dart';
import '../../utils/onboarding.dart';
import '../button/page_button.dart';
import '../form/language/language_selector.dart';
import '../text/roboto.dart';
import 'base_overlay.dart';

class WelcomeOverlay extends StatelessWidget {
  const WelcomeOverlay({super.key});

  Future<void> _loadOnboarding() async {
    await Onboarding.init();
  }

  @override
  Widget build(BuildContext context) {
    return ListenableBuilder(
      listenable: onboardingNotifier,
      builder: (BuildContext context, Widget? child) {
        if (onboardingNotifier.isOnboardingCompleted) {
          return const SizedBox.shrink();
        }

        return BaseOverlay(
          children: <Widget>[
            Column(
              children: <Widget>[
                RobotoText(
                  text: AppLocalizations.of(context)!.welcome,
                  fontWeight: FontWeight.bold,
                  fontSize: 20,
                ),
                RobotoText(
                  text: AppLocalizations.of(context)!.welcomeSelectLanguage,
                  fontSize: 16,
                  color: Palette.black,
                ),
                const SizedBox(height: 20),
                const LanguageSelector(),
                const SizedBox(height: 20),
                RobotoText(
                  text: AppLocalizations.of(context)!.welcomeChangeLater,
                  fontSize: 16,
                  color: Palette.black,
                ),
                const SizedBox(height: 20),
                PageButton(
                  buttonText: AppLocalizations.of(context)!.continuePrompt,
                  onPressed: _loadOnboarding,
                  navigateTo: AppRoute.onboarding.route,
                  textAlignment: MainAxisAlignment.center,
                ),
              ],
            ),
          ],
        );
      },
    );
  }
}
