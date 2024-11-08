import 'package:flame/flame.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:yaml/yaml.dart';

import '../constants/assets.dart' show configPath;

class Configuration {
  static late final String appName;
  static late final bool debugMode;
  static late final bool music;

  static Future<void> init() async {
    WidgetsFlutterBinding.ensureInitialized();
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
  }
}
