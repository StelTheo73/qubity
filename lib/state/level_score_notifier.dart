import 'package:flutter/material.dart';

class LevelScoreNotifier extends ChangeNotifier {
  final Map<int, double> _levelScore = <int, double>{};

  Map<int, double> get levelScore => _levelScore;

  double getLevelScore(int levelId) {
    return _levelScore[levelId] ?? 0;
  }

  void setLevelScore(int levelId, double score) {
    _levelScore[levelId] = score;
    notifyListeners();
  }

  void resetState() {
    _levelScore.clear();
    notifyListeners();
  }
}

final LevelScoreNotifier levelScoreNotifier = LevelScoreNotifier();
