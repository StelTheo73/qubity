import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

import '../components/button/page_button.dart';
import '../constants/routes.dart';
import '../utils/config.dart';
import 'base.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  late final List<dynamic> levels;

  @override
  Widget build(BuildContext context) {
    return BaseScreen(
      title: Configuration.appName,
      showBackButton: false,
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(25),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              PageButton(
                buttonText: AppLocalizations.of(context)!.levels,
                navigateTo: AppRoute.levels.route,
                icon: Icons.videogame_asset,
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
                buttonText: AppLocalizations.of(context)!.settings,
                navigateTo: AppRoute.settings.route,
                icon: Icons.settings,
              ),
              const SizedBox(height: 20),
              PageButton(
                buttonText: 'About',
                navigateTo: AppRoute.about.route,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
