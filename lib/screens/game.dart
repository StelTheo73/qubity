import 'package:flutter/material.dart';
import 'package:yaml/yaml.dart';

import '../components/navbar/navbar.dart';

class GameScreen extends StatefulWidget {
  GameScreen({super.key, required this.level});

  YamlMap level;

  @override
  _GameScreenState createState() => _GameScreenState();
}

class _GameScreenState extends State<GameScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(title: 'Game'),
      body: Center(
        child: Text('Game Page ${widget.level['id']}'),
      ),
    );
  }
}
