import 'package:flutter/services.dart';
import 'package:yaml/yaml.dart';

import '../constants/assets.dart';

class LevelLoader {
  static late final YamlMap levelGates;
  static late final YamlMap levelStates;

  static Future<void> init() async {
    levelGates = await _loadGates();
    levelStates = await _loadStates();
  }

  static Future<List<dynamic>> loadLevels() async {
    final levels = await rootBundle.loadString(levelsPath);
    return loadYaml(levels)['levels'] as List<dynamic>;
  }

  static Future<YamlMap> _loadGates() async {
    final levelGates = await rootBundle.loadString(levelGatesPath);
    return loadYaml(levelGates)['gates'] as YamlMap;
  }

  static Future<YamlMap> _loadStates() async {
    final levelStates = await rootBundle.loadString(levelStatesPath);
    return loadYaml(levelStates)['states'] as YamlMap;
  }

  // TODO
  static Future<void> getLevelgates() async {}

  // TODO
  static Future<void> getLevelStates() async {}
}
