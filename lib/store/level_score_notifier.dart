import 'package:flutter/material.dart';

import '../utils/device_store.dart';

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

  Future<void> init() async {
    final Map<String, double> scores = await DeviceStore.getLevelScores();
    scores.forEach((String key, double value) {
      _levelScore[int.parse(key)] = value;
    });
    notifyListeners();
  }

  void resetState() {
    _levelScore.clear();
    notifyListeners();
  }
}

final LevelScoreNotifier levelScoreNotifier = LevelScoreNotifier();
