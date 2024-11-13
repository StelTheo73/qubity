import 'package:flame/components.dart';
import 'package:flutter/material.dart';

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
      final Offset validPosition = validPositions[counter];
      final int spaces = 2 -
          levelStates
              .elementAt(counter)
              .toString()
              .split('|')
              .elementAt(0)
              .length;
      final int spacesBefore = spaces > 0 ? spaces : 0;
      final String spacesString = ' ' * spacesBefore;

      components.add(
        RectangleComponent(
          position: Vector2(validPosition.dx, validPosition.dy),
          anchor: Anchor.center,
          size: rectangleSize,
          scale: Vector2(1.0, 1.0),
          paint: Paint()..color = Colors.purple,
          children: <Component>[
            TextBoxComponent<TextPaint>(
              text: '$spacesString${levelStates.elementAt(counter)}',
              boxConfig: TextBoxConfig(
                margins: EdgeInsets.symmetric(
                  vertical: (textBoxSize.y - textSize) / 2,
                  // horizontal: textSize / 2,
                ),
              ),
              textRenderer: TextPaint(
                style: const TextStyle(
                  color: Colors.white,
                  fontSize: textSize,
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

  @override
  String toString() {
    return _providedStates.join(' ');
  }
}
