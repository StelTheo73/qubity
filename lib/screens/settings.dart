import 'package:flutter/material.dart';

import '../components/button/base_button.dart';
import '../constants/colors.dart';
import '../utils/utils.dart';
import 'base.dart';

class SettingsScreen extends StatefulWidget {
  const SettingsScreen({super.key});

  @override
  _SettingsScreenState createState() => _SettingsScreenState();
}

class _SettingsScreenState extends State<SettingsScreen> {
  @override
  Widget build(BuildContext context) {
    return const BaseScreen(
      title: 'Settings',
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            BaseButton(
              onPressed: Utils.resetGame,
              text: 'Delete Game Data',
              color: Palette.danger,
              width: 200,
            ),
          ],
        ),
      ),
    );
  }
}
