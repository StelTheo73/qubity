import 'package:flutter/foundation.dart';

class LevelHelpNotifier extends ChangeNotifier {
  final List<Map<String, String>> _levelHelpMap = <Map<String, String>>[];

  List<Map<String, String>> get levelHelpMap => _levelHelpMap;

  void setLevelHelpMap(List<Map<String, String>> levelHelpMap) {
    _levelHelpMap.clear();
    _levelHelpMap.addAll(levelHelpMap);
    notifyListeners();
  }

  void resetState() {
    _levelHelpMap.clear();
    notifyListeners();
  }
}

final LevelHelpNotifier levelHelpNotifier = LevelHelpNotifier();
