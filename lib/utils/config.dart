import 'package:flame/flame.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:yaml/yaml.dart';

import '../constants/assets.dart' show configPath;

class Configuration {
  static late final String appName;
  static late final bool debugMode;
  static late final bool music;
  static late final int noOfLevels;

  static Future<void> init() async {
    _loadGoogleFonts();
    Flame.device.fullScreen();
    Flame.device.setPortrait();
    await _loadConfig();
  }

  static Future<void> _loadConfig() async {
    final String config = await rootBundle.loadString(configPath);
    final YamlMap configMap = loadYaml(config) as YamlMap;
    appName = configMap['app']['name'] as String;
    debugMode = configMap['debugMode'] as bool;
    music = configMap['music'] as bool;
    noOfLevels = configMap['levels'] as int;
  }

  static void _loadGoogleFonts() {
    GoogleFonts.config.allowRuntimeFetching = false;

    LicenseRegistry.addLicense(() async* {
      final String license =
          await rootBundle.loadString('google_fonts/LICENSE.txt');
      yield LicenseEntryWithLineBreaks(<String>['google_fonts'], license);
    });
  }
}
