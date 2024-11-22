import 'package:flame/components.dart';
import 'package:flutter/material.dart';
import 'package:qartvm/qartvm.dart';

import '../objects/enemy.dart';
import '../objects/spaceship.dart';
import '../objects/state_component.dart';

const double _defaultOffsetX = 0.1;
final Map<int, double> _offsetXMap = <int, double>{
  2: 0.3,
  4: 0.15,
  8: 0.075,
};

class LevelStates {
  static final List<Enemy> levelEnemies = List<Enemy>.empty(growable: true);
  static final List<RectangleComponent> levelStateComponents =
      List<RectangleComponent>.empty(growable: true);
  static final Map<String, Offset> levelStatePositions = <String, Offset>{};
  static final List<Spaceship> levelSpaceships =
      List<Spaceship>.empty(growable: true);
  static final List<RectangleComponent> levelTargetComponents =
      List<RectangleComponent>.empty(growable: true);
  // A Map containing all valid level states i.e..
  // The boolean value indicates current spaceship location
  static final Map<String, bool> validLevelStates = <String, bool>{};

  static double stateComponentDimension = 28.0;

  static List<Offset> getValidPositions(Vector2 gameSize, int statesLength) {
    final int points = statesLength;
    final double offset = gameSize.x * (_offsetXMap[points] ?? _defaultOffsetX);
    final double availableWidth = gameSize.x - 2 * offset;
    final double positionY = gameSize.y * 0.7;

    return List<Offset>.generate(
      points,
      (int i) => Offset(offset + i * availableWidth / (points - 1), positionY),
    );
  }

  // Public Methods
  //
  static void setupLevelStates(
      Vector2 gameSize, Iterable<dynamic> levelStates) {
    final List<Offset> validPositions =
        getValidPositions(gameSize, levelStates.length);

    for (int counter = 0; counter < levelStates.length; counter++) {
      final String stateName = levelStates.elementAt(counter).toString();
      final String spacesString = _getSpaces(stateName);
      final Offset validPosition = validPositions[counter];

      // false indicates that the spaceship is not yet placed
      validLevelStates[stateName] = false;
      levelStatePositions[stateName] = validPosition;

      levelStateComponents.add(
        StateComponent(
          position: Vector2(validPosition.dx, validPosition.dy),
          paint: Paint()..color = Colors.purple,
          text: '$spacesString$stateName',
        ),
      );
    }
  }

  //
  static void createSpaceshipPositions(QRegister register) {
    for (final String state in register.amplitudes.keys) {
      final double real = register.amplitudes[state]!.re;
      final double imaginary = register.amplitudes[state]!.im;

      String stateString = '';

      if (real > 0) {
        stateString = '|$state>';
      } else if (real < 0) {
        stateString = '-|$state>';
      } else if (imaginary < 0) {
        stateString = '-i|$state>';
      } else if (imaginary > 0) {
        stateString = 'i|$state>';
      }

      if (stateString.isNotEmpty) {
        LevelStates.validLevelStates[stateString] = true;
      }
    }
  }

  //
  static void createLevelSpaceships() {
    for (final String state in LevelStates.validLevelStates.keys) {
      if (!LevelStates.validLevelStates[state]!) {
        continue;
      }

      final Offset position = LevelStates.levelStatePositions[state]!;

      final Spaceship spaceship = Spaceship(
        position.dx,
        position.dy - LevelStates.stateComponentDimension * 1.5,
      );
      LevelStates.levelSpaceships.add(spaceship);
    }
  }

  //
  static void createLevelTargets(
      Iterable<dynamic> levelTargets, String targetImagePath) {
    for (final dynamic target in levelTargets) {
      final String targetState = target.toString();
      final String spacesString = _getSpaces(targetState);
      final Offset position = LevelStates.levelStatePositions[targetState]!;

      final StateComponent targetComponent = StateComponent(
        position: Vector2(position.dx, 50),
        paint: Paint()..color = Colors.green,
        text: '$spacesString$targetState',
      );

      final Enemy enemy = Enemy(
        position.dx,
        50 + stateComponentDimension * 1.5,
        targetImagePath,
      );

      LevelStates.levelTargetComponents.add(targetComponent);
      LevelStates.levelEnemies.add(enemy);
    }
  }

  //
  static void removeLevelSpaceships(
      void Function(Iterable<Component> components) removeAll) {
    removeAll(LevelStates.levelSpaceships);
    LevelStates.levelSpaceships.clear();
  }

  //
  static void resetSpaceshipPositions() {
    for (final String state in LevelStates.validLevelStates.keys) {
      LevelStates.validLevelStates[state] = false;
    }
  }

  // Private Methods
  //
  static String _getSpaces(String stateName) {
    final int stateLength = stateName.split('|').elementAt(1).length + 1;
    if (stateLength == 4 || stateName.startsWith('-i')) {
      return ' '; // 1 space
    }

    if (stateName.startsWith('-') || stateName.startsWith('i')) {
      return '  '; // 2 spaces
    }
    return '   '; // 3 spaces
  }

  // Teardown
  //
  static void teardown(
      void Function(Iterable<Component> components) removeAll) {
    removeAll(LevelStates.levelStateComponents);
    removeAll(LevelStates.levelSpaceships);
    removeAll(LevelStates.levelTargetComponents);
    removeAll(LevelStates.levelEnemies);

    LevelStates.levelEnemies.clear();
    LevelStates.validLevelStates.clear();
    LevelStates.levelStateComponents.clear();
    LevelStates.levelStatePositions.clear();
    LevelStates.levelSpaceships.clear();
    LevelStates.levelTargetComponents.clear();
  }
}
