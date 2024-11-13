import 'package:flutter/material.dart';

import 'base.dart';

class SettingsScreen extends StatefulWidget {
  @override
  _SettingsScreenState createState() => _SettingsScreenState();
}

class _SettingsScreenState extends State<SettingsScreen> {
  @override
  Widget build(BuildContext context) {
    return const BaseScreen(
      title: 'Settings',
      body: Center(
        child: Text('Settings Page'),
      ),
    );
  }
}
