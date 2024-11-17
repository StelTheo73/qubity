import 'package:flame/components.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:qartvm/qartvm.dart';

import '../objects/spaceship.dart';

const double _defaultOffsetX = 0.1;
final Map<int, double> _offsetXMap = <int, double>{
  2: 0.3,
  4: 0.15,
  8: 0.075,
};

// Valid states for the game
final Map<String, bool> stateAmplitudes = <String, bool>{
  '|0>': false,
  '-|0>': false,
  'i|0>': false,
  '-i|0>': false,
  '|1>': false,
  '-|1>': false,
  'i|1>': false,
  '-i|1>': false,
  '|00>': false,
  '-|00>': false,
  '|01>': false,
  '-|01>': false,
  '|10>': false,
  '-|10>': false,
  '|11>': false,
  '-|11>': false,
};

class LevelStates {
  static final List<RectangleComponent> levelStateComponents =
      List<RectangleComponent>.empty(growable: true);
  static final Map<String, Offset> levelStatePositions = <String, Offset>{};
  static final List<Spaceship> levelSpaceships =
      List<Spaceship>.empty(growable: true);
  static final List<RectangleComponent> levelTargets =
      List<RectangleComponent>.empty(growable: true);
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

  static void setupLevelStates(
      Vector2 gameSize, Iterable<dynamic> levelStates) {
    final List<Offset> validPositions =
        getValidPositions(gameSize, levelStates.length);

    final Vector2 rectangleSize = Vector2(
      stateComponentDimension,
      stateComponentDimension,
    );
    final Vector2 textBoxSize = Vector2(
      stateComponentDimension,
      stateComponentDimension,
    );
    const double textSize = 10.0;

    for (int counter = 0; counter < levelStates.length; counter++) {
      final String stateName = levelStates.elementAt(counter).toString();
      final String spacesString = _getSpaces(stateName);
      final Offset validPosition = validPositions[counter];

      // false indicates that the spaceship is not yet placed
      validLevelStates[stateName] = false;
      levelStatePositions[stateName] = validPosition;

      levelStateComponents.add(
        RectangleComponent(
          position: Vector2(validPosition.dx, validPosition.dy),
          anchor: Anchor.center,
          size: rectangleSize,
          scale: Vector2(1.0, 1.0),
          paint: Paint()..color = Colors.purple,
          children: <Component>[
            TextBoxComponent<TextPaint>(
              text: '$spacesString$stateName',
              boxConfig: TextBoxConfig(
                margins: EdgeInsets.symmetric(
                  vertical: (textBoxSize.y - textSize) / 2,
                  horizontal: 1,
                ),
              ),
              textRenderer: TextPaint(
                style: GoogleFonts.roboto(
                  textStyle: const TextStyle(
                    color: Colors.white,
                    fontSize: textSize,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              size: textBoxSize,
              anchor: Anchor.topLeft,
            ),
          ],
        ),
      );
    }
  }

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

  static void createLevelSpaceships() {
    for (final String state in LevelStates.validLevelStates.keys) {
      if (!LevelStates.validLevelStates[state]!) {
        continue;
      }

      final Offset position = LevelStates.levelStatePositions[state] as Offset;

      final Spaceship spaceship = Spaceship(
        position.dx,
        position.dy - LevelStates.stateComponentDimension * 1.5,
      );
      LevelStates.levelSpaceships.add(spaceship);
    }
  }

  static void createLevelTargets() {}

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

  static void teardown(void Function(Component component) removeGameComponent) {
    // ignore: prefer_foreach
    for (final Component component in LevelStates.levelStateComponents) {
      removeGameComponent(component);
    }
    // ignore: prefer_foreach
    for (final Spaceship spaceship in LevelStates.levelSpaceships) {
      removeGameComponent(spaceship);
    }

    LevelStates.levelStateComponents.clear();
    LevelStates.validLevelStates.clear();
    LevelStates.levelStatePositions.clear();
    LevelStates.levelSpaceships.clear();
  }
}
