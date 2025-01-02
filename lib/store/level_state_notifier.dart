import 'package:flutter/material.dart';

class LevelStateNotifier extends ChangeNotifier {
  int _levelId = 1;

  int get levelId => _levelId;

  int get nextLevelId => _levelId + 1;

  void setLevelId(int levelId) {
    _levelId = levelId;
    notifyListeners();
  }

  void resetState() {
    _levelId = 1;
    notifyListeners();
  }
}

final LevelStateNotifier levelStateNotifier = LevelStateNotifier();
