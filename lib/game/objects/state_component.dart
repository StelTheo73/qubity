import 'package:flame/components.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

const double _stateComponentDimension = 28.0;
Vector2 _size = Vector2(_stateComponentDimension, _stateComponentDimension);
const double _textSize = 10.0;

class StateComponent extends RectangleComponent {
  StateComponent({
    required Vector2 position,
    required Paint paint,
    required String text,
    Vector2? size,
    double? textSize,
  }) : super(
          position: position,
          anchor: Anchor.center,
          size: size ?? _size,
          paint: paint,
          scale: Vector2(1.0, 1.0),
          children: <Component>[
            TextBoxComponent<TextPaint>(
              text: text,
              boxConfig: TextBoxConfig(
                margins: EdgeInsets.symmetric(
                  vertical:
                      ((size?.y ?? _size.y) - (textSize ?? _textSize)) / 2,
                  horizontal: 1,
                ),
              ),
              textRenderer: TextPaint(
                style: GoogleFonts.roboto(
                  textStyle: const TextStyle(
                    color: Colors.white,
                    fontSize: _textSize,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              size: size ?? _size,
              anchor: Anchor.topLeft,
            ),
          ],
        );
}
