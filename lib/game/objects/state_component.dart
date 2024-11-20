import 'package:flame/components.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

double _stateComponentDimension = 28.0;
Vector2 _size = Vector2(_stateComponentDimension, _stateComponentDimension);
Vector2 _textBoxSize =
    Vector2(_stateComponentDimension, _stateComponentDimension);
double _textSize = 10.0;

class StateComponent extends RectangleComponent {
  StateComponent({
    required Vector2 position,
    required Paint paint,
    required String text,
  }) : super(
          position: position,
          anchor: Anchor.center,
          size: _size,
          paint: paint,
          scale: Vector2(1.0, 1.0),
          children: <Component>[
            TextBoxComponent<TextPaint>(
              text: text,
              boxConfig: TextBoxConfig(
                margins: EdgeInsets.symmetric(
                  vertical: (_textBoxSize.y - _textSize) / 2,
                  horizontal: 1,
                ),
              ),
              textRenderer: TextPaint(
                style: GoogleFonts.roboto(
                  textStyle: TextStyle(
                    color: Colors.white,
                    fontSize: _textSize,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              size: _textBoxSize,
              anchor: Anchor.topLeft,
            ),
          ],
        );
}
