import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

import '../components/button/base_button.dart';
import '../components/form/language/language_selector.dart';
import '../constants/colors.dart';
import '../utils/utils.dart';
import 'base.dart';

class SettingsScreen extends StatefulWidget {
  const SettingsScreen({super.key});

  @override
  State<StatefulWidget> createState() => _SettingsScreenState();
}

class _SettingsScreenState extends State<SettingsScreen> {
  @override
  Widget build(BuildContext context) {
    return BaseScreen(
      title: AppLocalizations.of(context)!.settings,
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            const SizedBox(height: 20),
            const LanguageSelector(),
            const SizedBox(height: 20),
            BaseButton(
              onPressed: Utils.resetGame,
              text: AppLocalizations.of(context)!.deleteGameData,
              color: Palette.danger,
              width: 200,
            ),
          ],
        ),
      ),
    );
  }
}
