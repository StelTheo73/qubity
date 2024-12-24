import 'package:flame/flame.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:yaml/yaml.dart';

import '../constants/assets.dart' show configPath;

class Configuration {
  static late final String appName;
  static late final String defaultLanguage;
  static late final bool debugMode;
  static late final List<Locale> locales;
  static late final int maxQuizScoreHistory;
  static late final bool music;
  static late final int noOfLevels;
  static late final int tutorialLevelId;

  static Future<void> init() async {
    _loadGoogleFonts();
    Flame.device.setPortrait();
    await _loadConfig();
  }

  static Future<void> _loadConfig() async {
    final String config = await rootBundle.loadString(configPath);
    final YamlMap configMap = loadYaml(config) as YamlMap;
    appName = configMap['app']['name'] as String;
    defaultLanguage = configMap['defaultLanguage'] as String;
    debugMode = configMap['debugMode'] as bool;
    locales = _getSupportedLocales(configMap['locales'] as YamlList);
    maxQuizScoreHistory = configMap['maxQuizScoreHistory'] as int;
    music = configMap['music'] as bool;
    noOfLevels = configMap['levels'] as int;
    tutorialLevelId = configMap['tutorialLevelId'] as int;
  }

  static void _loadGoogleFonts() {
    GoogleFonts.config.allowRuntimeFetching = false;

    LicenseRegistry.addLicense(() async* {
      final String license =
          await rootBundle.loadString('google_fonts/LICENSE.txt');
      yield LicenseEntryWithLineBreaks(<String>['google_fonts'], license);
    });
  }

  static List<Locale> _getSupportedLocales(YamlList locales) {
    final List<Locale> supportedLocales = <Locale>[];
    for (final locale in locales.value) {
      supportedLocales.add(Locale(locale as String));
    }
    return supportedLocales;
  }
}
