import 'dart:math';

import '../constants/assets.dart';

class GameUtils {
  static final Random randomGenerator = Random();

  static String extractImagePath(String imagePath) {
    return imagePath.startsWith('assets/images')
        ? imagePath.replaceFirst('assets/images/', '')
        : imagePath;
  }

  static String getAsteroidImagePath() {
    final int index = randomGenerator.nextInt(asteroidPaths.length);
    return extractImagePath(asteroidPaths[index]);
  }
}
