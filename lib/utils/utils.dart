import 'dart:ui';

import 'package:flutter/material.dart';

import '../state/level_score_notifier.dart';
import '../state/spaceship_notifier.dart';
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

  static void resetGame() {
    levelScoreNotifier.resetState();
    spaceshipNotifier.resetState();
    DeviceStore.resetDeviceStore();
  }
}
