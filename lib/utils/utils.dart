import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:yaml/yaml.dart';

import '../store/current_score_notifier.dart';
import '../store/level_help_notifier.dart';
import '../store/level_score_notifier.dart';
import '../store/level_state_notifier.dart';
import '../store/locale_notifier.dart';
import '../store/spaceship_notifier.dart';
import '../store/tutorial_notifier.dart';
import 'device_store.dart';

class Utils {
  static FlutterView view =
      WidgetsBinding.instance.platformDispatcher.views.first;
  static late final double screenWidth;
  static late final double screenHeight;

  static void init() {
    screenWidth = view.display.size.width;
    screenHeight = view.display.size.height;
  }

  static Future<void> changeLanguage(String language) async {
    localeNotifier.setLocale(language);
    await DeviceStore.setLanguage(language);
  }

  static void enterFullScreen() {
    SystemChrome.setEnabledSystemUIMode(SystemUiMode.immersiveSticky);
  }

  static void exitFullScreen() {
    SystemChrome.setEnabledSystemUIMode(SystemUiMode.edgeToEdge);
  }

  static DateTime getLocalTime() {
    return DateTime.now();
  }

  static DateTime getUtcTime() {
    return DateTime.now().toUtc();
  }

  static String getFormattedDate(DateTime date) {
    final String day = date.day.toString().padLeft(2, '0');
    final String month = date.month.toString().padLeft(2, '0');
    final String year = date.year.toString();
    final String hour = date.hour.toString().padLeft(2, '0');
    final String minute = date.minute.toString().padLeft(2, '0');
    return '$day/$month/$year $hour:$minute';
  }

  static Future<YamlMap> loadYamlMap(String filePath) async {
    final String yamlString = await rootBundle.loadString(filePath);
    return loadYaml(yamlString) as YamlMap;
  }

  static void resetGame() {
    currentScoreNotifier.resetState();
    levelHelpNotifier.resetState();
    levelScoreNotifier.resetState();
    levelStateNotifier.resetState();
    spaceshipNotifier.resetState();
    tutorialNotifier.resetState();
    DeviceStore.resetDeviceStore();
  }
}
