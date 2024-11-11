import 'package:flame/components.dart';
import 'package:flutter/material.dart';
import 'package:yaml/yaml.dart';

class LevelStates {
  LevelStates(YamlList states) {
    _providedStates = states;
  }

  late final YamlList _providedStates;

  YamlList get levelStates => _providedStates;

  List<Offset> getValidPositions(Vector2 gameSize) {
    final int points = _providedStates.length;
    final double offset = gameSize.x * 0.1;
    final double availableWidth = gameSize.x - 2 * offset;
    final double positionY = gameSize.y * 0.7;

    return List<Offset>.generate(
      points,
      (int i) => Offset(offset + i * availableWidth / (points - 1), positionY),
    );
  }

  @override
  String toString() {
    return _providedStates.join(' ');
  }
}
