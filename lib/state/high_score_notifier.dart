import 'package:flutter/material.dart';

class HighScoreNotifier extends ChangeNotifier {
  bool _highScore = false;

  bool get highScore => _highScore;

  void setHighScore(bool value) {
    _highScore = value;
    notifyListeners();
  }

  void resetState() {
    _highScore = false;
    notifyListeners();
  }
}

final HighScoreNotifier highScoreNotifier = HighScoreNotifier();
