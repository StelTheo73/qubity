import 'package:flutter/material.dart';

import '../components/alert/delete_data.dart';
import '../components/button/base_button.dart';
import '../components/form/language/language_selector.dart';
import '../constants/colors.dart';
import '../l10n/app_localizations.dart';
import 'base.dart';

class SettingsScreen extends StatefulWidget {
  const SettingsScreen({super.key});

  @override
  State<SettingsScreen> createState() => _SettingsScreenState();
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
            const SizedBox(height: 100),
            BaseButton(
              onPressed: () => DeleteDataAlert.show(context),
              text: AppLocalizations.of(context)!.deleteGameData,
              color: Palette.danger,
              width: 200,
              icon: Icons.delete_forever_outlined,
              mainAxisAlignment: MainAxisAlignment.start,
            ),
          ],
        ),
      ),
    );
  }
}
