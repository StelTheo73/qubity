import 'package:flame/components.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

const double _defaultOffsetX = 0.1;
final Map<int, double> _offsetXMap = <int, double>{
  2: 0.3,
  4: 0.15,
  8: 0.075,
};

class LevelStates {
  LevelStates(Iterable<dynamic> states) {
    _providedStates = states;
  }

  late final Iterable<dynamic> _providedStates;

  Iterable<dynamic> get levelStates => _providedStates;

  List<Offset> getValidPositions(Vector2 gameSize) {
    final int points = _providedStates.length;
    final double offset = gameSize.x * (_offsetXMap[points] ?? _defaultOffsetX);
    final double availableWidth = gameSize.x - 2 * offset;
    final double positionY = gameSize.y * 0.7;

    return List<Offset>.generate(
      points,
      (int i) => Offset(offset + i * availableWidth / (points - 1), positionY),
    );
  }

  List<RectangleComponent> getStatesComponents(Vector2 gameSize) {
    final List<RectangleComponent> components =
        List<RectangleComponent>.empty(growable: true);
    final List<Offset> validPositions = getValidPositions(gameSize);

    final Vector2 rectangleSize = Vector2(28, 28);
    final Vector2 textBoxSize = Vector2(28, 28);
    const double textSize = 10.0;

    for (int counter = 0; counter < _providedStates.length; counter++) {
      final String stateName = levelStates.elementAt(counter).toString();
      final String spacesString = _getSpaces(stateName);
      final Offset validPosition = validPositions[counter];

      components.add(
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

    return components;
  }

  String _getSpaces(String stateName) {
    final int stateLength = stateName.split('|').elementAt(1).length + 1;
    if (stateLength == 4 || stateName.startsWith('-i')) {
      return ' '; // 1 space
    }

    if (stateName.startsWith('-') || stateName.startsWith('i')) {
      return '  '; // 2 spaces
    }
    return '   '; // 3 spaces
  }

  @override
  String toString() {
    return _providedStates.join(' ');
  }
}
