import 'package:flutter/material.dart';

class CurrentScoreNotifier extends ChangeNotifier {
  bool _highScore = false;
  double _currentScore = 0;

  bool get highScore => _highScore;

  double get currentScore => _currentScore;

  void setCurrentScore(double value) {
    _currentScore = value;
    notifyListeners();
  }

  void setHighScore(bool value) {
    _highScore = value;
    notifyListeners();
  }

  void resetState() {
    _currentScore = 0;
    _highScore = false;
    notifyListeners();
  }
}

final CurrentScoreNotifier currentScoreNotifier = CurrentScoreNotifier();
