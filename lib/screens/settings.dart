import 'package:flutter/material.dart';

import '../components/navbar/navbar.dart';

class SettingsScreen extends StatefulWidget {
  @override
  _SettingsScreenState createState() => _SettingsScreenState();
}

class _SettingsScreenState extends State<SettingsScreen> {
  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      appBar: CustomAppBar(title: 'Settings'),
      body: Center(
        child: Text('Settings Page'),
      ),
    );
  }
}
