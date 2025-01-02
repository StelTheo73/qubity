import 'package:flame/components.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../constants/colors.dart';

const double _stateComponentDimension = 28.0;
Vector2 _size = Vector2(_stateComponentDimension, _stateComponentDimension);
const double _textSize = 14.0;

class StateComponent extends RectangleComponent {
  StateComponent({
    required Vector2 position,
    required Paint paint,
    required String text,
    Vector2? size,
  }) : super(
          position: position,
          anchor: Anchor.center,
          size: size ?? _size,
          paint: paint,
          scale: Vector2(1.0, 1.0),
          children: <Component>[
            TextBoxComponent<TextPaint>(
              text: text,
              align: Anchor.center,
              textRenderer: TextPaint(
                style: GoogleFonts.roboto(
                  textStyle: const TextStyle(
                    color: Palette.black,
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
