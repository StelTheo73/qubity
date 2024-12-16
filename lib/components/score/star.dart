import 'package:flutter/material.dart';

import '../../constants/assets.dart';

abstract class Star extends StatelessWidget {
  const Star({
    super.key,
    required this.imagePath,
    required this.width,
    required this.height,
  });

  final String imagePath;
  final double width;
  final double height;

  @override
  Widget build(BuildContext context) {
    return Image.asset(
      imagePath,
      width: width,
      height: height,
    );
  }
}

class FullStar extends Star {
  const FullStar({
    super.key,
    required super.width,
    required super.height,
  }) : super(
          imagePath: starFullPath,
        );
}

class HalfStar extends Star {
  const HalfStar({
    super.key,
    required super.width,
    required super.height,
  }) : super(
          imagePath: starHalfPath,
        );
}

class EmptyStar extends Star {
  const EmptyStar({
    super.key,
    required super.width,
    required super.height,
  }) : super(
          imagePath: starEmptyPath,
        );
}
