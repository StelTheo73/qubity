import 'package:flutter/services.dart';
import 'package:yaml/yaml.dart';

import '../constants/assets.dart'
    show levelGatesPath, levelStatesPath, levelsPath;
import 'device_store.dart';

class LevelLoader {
  static late final YamlMap levelGates;
  static late final YamlMap levelStates;

  static Future<void> init() async {
    levelGates = await _loadGates();
    levelStates = await _loadStates();
  }

  static Future<YamlList> loadLevels() async {
    final String levels = await rootBundle.loadString(levelsPath);
    return loadYaml(levels)['levels'] as YamlList;
  }

  static Future<YamlMap> _loadGates() async {
    final String levelGates = await rootBundle.loadString(levelGatesPath);
    return loadYaml(levelGates)['gates'] as YamlMap;
  }

  static Future<YamlMap> _loadStates() async {
    final String levelStates = await rootBundle.loadString(levelStatesPath);
    return loadYaml(levelStates)['states'] as YamlMap;
  }

  static Future<List<String>> getLevelGates(YamlMap level) async {
    return level['gates'] as List<String>;
  }

  static Future<List<String>> getLevelStates(YamlMap level) async {
    return level['states'] as List<String>;
  }

  static Future<int> getLastUnlockedLevel() async {
    return await DeviceStore.prefs.getInt(DeviceStoreKeys.unlockedLevel.key) ??
        1;
  }
}
