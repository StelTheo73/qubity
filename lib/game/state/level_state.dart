import 'package:flame/components.dart';
import 'package:flutter/material.dart';
import 'package:qartvm/qartvm.dart';

import '../../constants/colors.dart';
import '../../constants/gates.dart';
import '../components/menu_button.dart';
import '../components/state.dart';
import '../objects/asteroid.dart';
import '../objects/gate.dart';
import '../objects/missile.dart';
import '../objects/spaceship.dart';

const double _defaultOffsetX = 0.1;
final Map<int, double> _offsetXMap = <int, double>{
  2: 0.3,
  4: 0.15,
  8: 0.075,
};

class LevelStates {
  static final List<Asteroid> levelEnemies =
      List<Asteroid>.empty(growable: true);
  static final List<GateComponent> levelGateComponents =
      List<GateComponent>.empty(growable: true);
  static final List<RectangleComponent> levelStateComponents =
      List<RectangleComponent>.empty(growable: true);
  static final Map<String, Offset> levelStatePositions = <String, Offset>{};
  static final List<Spaceship> levelSpaceships =
      List<Spaceship>.empty(growable: true);
  static final List<RectangleComponent> levelTargetComponents =
      List<RectangleComponent>.empty(growable: true);
  // A Map containing all valid level states i.e. { '|00>': false }
  // The boolean value indicates current spaceship location
  static final Map<String, bool> validLevelStates = <String, bool>{};

  static double stateComponentDimension = 28.0;

  // Public Methods
  //
  static void setupLevelStates(
      Vector2 gameSize, Iterable<dynamic> levelStates) {
    final List<Offset> validPositions =
        getValidPositions(gameSize, levelStates.length);

    for (int counter = 0; counter < levelStates.length; counter++) {
      final String stateName = levelStates.elementAt(counter).toString();
      final Offset validPosition = validPositions[counter];

      // false indicates that the spaceship is not yet placed
      validLevelStates[stateName] = false;
      levelStatePositions[stateName] = validPosition;

      levelStateComponents.add(
        StateComponent(
          position: Vector2(validPosition.dx, validPosition.dy),
          paint: Paint()..color = Palette.secondary,
          text: stateName.replaceFirst('|', '').replaceAll('>', ''),
        ),
      );
    }
  }

  //
  static void createLevelGates(Vector2 gameSize, List<String> levelGates) {
    const double boxSize = 50.0;
    final double initialOffsetX = gameSize.x * 0.1;
    final double initialOffsetY = gameSize.y * 0.95;
    double offsetX = initialOffsetX;

    for (int i = 0; i < levelGates.length; i++) {
      final GateComponent gateComponent = GateComponent(
        Gate.getGateFromString(levelGates[i]),
        offsetX,
        initialOffsetY,
      );
      offsetX += 1.5 * boxSize;
      LevelStates.levelGateComponents.add(gateComponent);
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
  static void createLevelTargets(Iterable<dynamic> levelTargets) {
    for (final dynamic target in levelTargets) {
      final String targetState = target.toString();
      final Offset position = LevelStates.levelStatePositions[targetState]!;

      final StateComponent targetComponent = StateComponent(
        position: Vector2(position.dx, 30 + MenuButton.menuButtonSize.y),
        paint: Paint()..color = Palette.primary,
        text: targetState.replaceFirst('|', '').replaceAll('>', ''),
      );

      final Asteroid enemy = Asteroid(
        position.dx,
        30 +
            LevelStates.stateComponentDimension * 1.5 +
            MenuButton.menuButtonSize.y,
      );

      LevelStates.levelTargetComponents.add(targetComponent);
      LevelStates.levelEnemies.add(enemy);
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
  static String getRegisterText(QRegister register, {bool wrapText = false}) {
    String text = '';
    int counter = 1;

    for (final String state in register.amplitudes.keys) {
      final double real = register.amplitudes[state]!.re;
      final double imaginary = register.amplitudes[state]!.im;

      String stateString = '';

      if (real > 0) {
        stateString = ' + |$state>';
      } else if (real < 0) {
        stateString = ' - |$state>';
      } else if (imaginary < 0) {
        stateString = ' - i|$state>';
      } else if (imaginary > 0) {
        stateString = ' + i|$state>';
      }

      counter++;
      if (wrapText && counter % 4 == 0) {
        stateString += '\n';
      }

      text += stateString;
    }

    // remove leading space
    text = text.replaceFirst(' ', '');
    // remove leading spaces after newline
    text = text.replaceAll('\n ', '\n');
    // remove leading '+', if any
    if (text.startsWith('+')) {
      text = text.replaceFirst('+', ' ');
    }

    return text;
  }

  //
  static List<Offset> getValidPositions(Vector2 gameSize, int statesLength) {
    final int points = statesLength;
    final double offset = gameSize.x * (_offsetXMap[points] ?? _defaultOffsetX);
    final double availableWidth = gameSize.x - 2 * offset;
    final double positionY = gameSize.y * 0.6;

    return List<Offset>.generate(
      points,
      (int i) => Offset(offset + i * availableWidth / (points - 1), positionY),
    );
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

  // Teardown
  //
  static void teardown(
    void Function(Iterable<Component> components) removeAll,
    ComponentSet children,
  ) {
    removeAll(LevelStates.levelGateComponents);
    removeAll(LevelStates.levelStateComponents);
    removeAll(LevelStates.levelSpaceships);
    removeAll(LevelStates.levelTargetComponents);

    children
        .query<Asteroid>()
        .forEach((Asteroid asteroid) => asteroid.removeFromParent());
    children
        .query<Missile>()
        .forEach((Missile missile) => missile.removeFromParent());

    LevelStates.levelGateComponents.clear();
    LevelStates.levelEnemies.clear();
    LevelStates.validLevelStates.clear();
    LevelStates.levelStateComponents.clear();
    LevelStates.levelStatePositions.clear();
    LevelStates.levelSpaceships.clear();
    LevelStates.levelTargetComponents.clear();
  }
}
