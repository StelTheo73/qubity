import 'package:flutter/services.dart';
import 'package:yaml/yaml.dart';

import '../constants/assets.dart'
    show
        levelGatesPath,
        levelHelpPath,
        levelStatesPath,
        levelTutorialsPath,
        levelsPath;
import 'device_store.dart';
import 'utils.dart';

class LevelLoader {
  static late final YamlMap levelGates;
  static late final YamlMap levelStates;

  static Future<void> init() async {
    levelGates = await _loadGates();
    levelStates = await _loadStates();
  }

  static Future<YamlMap> getLevelById(int id) async {
    final YamlList levels = await loadLevels();
    if (id > levels.length) {
      throw ArgumentError('Level $id does not exist');
    }
    return levels[id - 1] as YamlMap;
  }

  static List<String> getLevelGates(YamlMap level) {
    return (levelGates[level['gates'] as String] as YamlList)
        .value
        .map((dynamic gate) {
      return gate as String;
    }).toList();
  }

  static YamlMap getLevelStates(YamlMap level) {
    return levelStates[level['states'] as String] as YamlMap;
  }

  static YamlList getLevelTargets(YamlMap level) {
    return level['targets'] as YamlList;
  }

  static Future<List<Map<String, String>>> getLevelHelp(YamlMap level) async {
    final List<String> levelGates = getLevelGates(level);
    final YamlMap helpYaml = await Utils.loadYamlMap(levelHelpPath);

    final List<YamlMap> gateSlides =
        levelGates.map((gate) => helpYaml['gates'][gate] as YamlMap).toList();

    final List<Map<String, String>> slides = gateSlides.expand((gate) {
      return (gate['slides']['en'] as YamlList)
          .map((slide) => Map<String, String>.from(slide as YamlMap));
    }).toList();

    return slides;
  }

  static Future<List<Map<String, String>>> getLevelTutorial(int levelId) async {
    try {
      final YamlMap tutorialYaml =
          await Utils.loadYamlMap('$levelTutorialsPath$levelId.yml');

      final List<Map<String, String>> slides =
          (tutorialYaml['slides']['en'] as YamlList)
              .map((slide) => Map<String, String>.from(slide as YamlMap))
              .toList();

      return slides;
    } catch (e) {
      return <Map<String, String>>[];
    }
  }

  static Future<int> getLastUnlockedLevel() async {
    return await DeviceStore.prefs.getInt(
          DeviceStoreKeys.unlockedLevel.key,
        ) ??
        1;
  }

  static Future<YamlList> loadLevels() async {
    final String levels = await rootBundle.loadString(levelsPath);
    return loadYaml(levels)['levels'] as YamlList;
  }

  // Private Methods
  // ---------------
  static Future<YamlMap> _loadGates() async {
    final String levelGates = await rootBundle.loadString(levelGatesPath);
    return loadYaml(levelGates)['gates'] as YamlMap;
  }

  static Future<YamlMap> _loadStates() async {
    final String levelStates = await rootBundle.loadString(levelStatesPath);
    return loadYaml(levelStates)['states'] as YamlMap;
  }
}
