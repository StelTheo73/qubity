import 'package:flutter/material.dart';

class TutorialNotifier extends ChangeNotifier {
  final List<Map<String, String>> _tutorialMap = <Map<String, String>>[];

  List<Map<String, String>> get tutorialMap => _tutorialMap;

  void setTutorialMap(List<Map<String, String>> tutorialMap) {
    _tutorialMap.clear();
    _tutorialMap.addAll(tutorialMap);
    notifyListeners();
  }

  void resetState() {
    _tutorialMap.clear();
    notifyListeners();
  }
}

final TutorialNotifier tutorialNotifier = TutorialNotifier();
