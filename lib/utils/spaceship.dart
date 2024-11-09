import 'package:flutter/material.dart';

import '../constants/spaceships.dart';

class SpaceshipLoader {
  Future<void> init(BuildContext context) async {
    await _cacheSpaceshipImages(context);
  }

  Future<void> _cacheSpaceshipImages(BuildContext context) async {
    for (final dynamic spaceship in spaceships.values) {
      final String imagePath = spaceship['image'] as String;
      final Image image = Image.asset(imagePath);
      await precacheImage(image.image, context);
    }
  }
}
