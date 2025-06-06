import 'package:flutter/material.dart';

import '../components/button/page_button.dart';
import '../components/overlays/welcome_overlay.dart';
import '../constants/routes.dart';
import '../l10n/app_localizations.dart';
import '../utils/config.dart';
import '../utils/level.dart';
import 'base.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    return BaseScreen(
      title: Configuration.appName,
      showBackButton: false,
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(25),
          child: Stack(
            children: <Widget>[
              Column(
                mainAxisSize: MainAxisSize.min,
                children: <Widget>[
                  PageButton(
                    buttonText: AppLocalizations.of(context)!.levels,
                    navigateTo: AppRoute.levels.route,
                    icon: Icons.format_list_numbered,
                  ),
                  const SizedBox(height: 20),
                  PageButton(
                    buttonText: AppLocalizations.of(context)!.spaceships,
                    navigateTo: AppRoute.spaceships.route,
                    icon: Icons.rocket,
                  ),
                  const SizedBox(height: 20),
                  PageButton(
                    buttonText: AppLocalizations.of(context)!.quiz,
                    navigateTo: AppRoute.quizMenu.route,
                    icon: Icons.quiz,
                  ),
                  const SizedBox(height: 20),
                  PageButton(
                    buttonText: AppLocalizations.of(context)!.tutorial,
                    navigateTo: AppRoute.tutorial.route,
                    icon: Icons.school,
                    navigateArguments: LevelLoader.tutorialLevel,
                  ),
                  const SizedBox(height: 20),
                  PageButton(
                    buttonText: AppLocalizations.of(context)!.settings,
                    navigateTo: AppRoute.settings.route,
                    icon: Icons.settings,
                  ),
                ],
              ),
              const WelcomeOverlay(),
            ],
          ),
        ),
      ),
    );
  }
}
