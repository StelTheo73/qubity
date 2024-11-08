import 'package:flutter/material.dart';

import '../components/button/page_button.dart';
import '../components/navbar/navbar.dart';
import '../constants/routes.dart';
import '../utils/config.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  late final List<dynamic> levels;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(
        title: Configuration.appName,
        showBackButton: false,
      ),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(25),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              PageButton(
                  buttonText: 'Levels', navigateTo: AppRoute.levels.route),
              const SizedBox(height: 20),
              PageButton(
                  buttonText: 'Settings', navigateTo: AppRoute.settings.route),
              const SizedBox(height: 20),
              PageButton(buttonText: 'About', navigateTo: AppRoute.about.route),
            ],
          ),
        ),
      ),
    );
  }
}
