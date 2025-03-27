import 'package:flame_audio/flame_audio.dart';
import 'package:flutter/services.dart';
import 'package:yaml/yaml.dart';

import '../constants/assets.dart'
    show
        levelGatesPath,
        levelHelpPath,
        levelStatesPath,
        levelTutorialsPath,
        levelsPath;
import '../constants/sounds.dart';
import '../store/locale_notifier.dart';
import 'config.dart';
import 'utils.dart';

class LevelLoader {
  static late final YamlMap levelGates;
  static late final YamlMap levelStates;
  static late final YamlMap tutorialLevel;

  static Future<void> init() async {
    final List<YamlMap> results = await Future.wait(<Future<YamlMap>>[
      _loadGates(),
      _loadStates(),
      _loadTutorialLevel(),
    ]);

    levelGates = results[0];
    levelStates = results[1];
    tutorialLevel = results[2];

    await _loadSounds();
  }

  static Future<YamlMap> getLevelById(
    int id, {
    bool includeTutorial = true,
  }) async {
    final YamlList levels = await loadLevels(includeTutorial: includeTutorial);
    if (id > levels.length) {
      throw ArgumentError('Level $id does not exist');
    }
    return levels[id] as YamlMap;
  }

  static List<String> getLevelGates(YamlMap level) {
    return (levelGates[level['gates'] as String] as YamlList).value.map((
      dynamic gate,
    ) {
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
    final String language = localeNotifier.locale.languageCode;

    final List<YamlMap> gateSlides =
        levelGates
            .map((dynamic gate) => helpYaml['gates'][gate] as YamlMap)
            .toList();

    final List<Map<String, String>> slides =
        gateSlides.expand((dynamic gate) {
          return (gate['slides'][language] as YamlList).map(
            (dynamic slide) => Map<String, String>.from(slide as YamlMap),
          );
        }).toList();

    return slides;
  }

  static Future<List<Map<String, String>>> getLevelTutorial(int levelId) async {
    try {
      final YamlMap tutorialYaml = await Utils.loadYamlMap(
        '$levelTutorialsPath$levelId.yml',
      );
      final String language = localeNotifier.locale.languageCode;
      final List<Map<String, String>> slides =
          (tutorialYaml['slides'][language] as YamlList)
              .map(
                (dynamic slide) => Map<String, String>.from(slide as YamlMap),
              )
              .toList();

      return slides;
    } catch (e) {
      return <Map<String, String>>[];
    }
  }

  static Future<YamlList> loadLevels({bool includeTutorial = false}) async {
    final String levelsString = await rootBundle.loadString(levelsPath);

    final YamlList levelsList =
        await loadYaml(levelsString)['levels'] as YamlList;

    if (includeTutorial) {
      return levelsList;
    }

    return YamlList.wrap(
      levelsList.where((dynamic level) {
        return level['id'] != Configuration.tutorialLevelId;
      }).toList(),
    );
  }

  // Private Methods
  // ---------------
  static Future<YamlMap> _loadGates() async {
    final String levelGates = await rootBundle.loadString(levelGatesPath);
    return loadYaml(levelGates)['gates'] as YamlMap;
  }

  static Future<void> _loadSounds() async {
    final List<String> sounds =
        Sounds.values.map((Sounds sound) => sound.sound).toList();

    await FlameAudio.audioCache.loadAll(sounds);
  }

  static Future<YamlMap> _loadStates() async {
    final String levelStates = await rootBundle.loadString(levelStatesPath);
    return loadYaml(levelStates)['states'] as YamlMap;
  }

  static Future<YamlMap> _loadTutorialLevel() async {
    return getLevelById(Configuration.tutorialLevelId);
  }
}
