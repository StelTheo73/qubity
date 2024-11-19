import 'package:flame/components.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class StateComponent extends RectangleComponent {
  StateComponent({
    required Vector2 position,
    required Anchor anchor,
    required Vector2 size,
    required Paint paint,
    required String text,
    required Vector2 textBoxSize,
    required double textSize,
  }) : super(
          position: position,
          anchor: anchor,
          size: size,
          paint: paint,
          scale: Vector2(1.0, 1.0),
          children: <Component>[
            TextBoxComponent<TextPaint>(
              text: text,
              boxConfig: TextBoxConfig(
                margins: EdgeInsets.symmetric(
                  vertical: (textBoxSize.y - textSize) / 2,
                  horizontal: 1,
                ),
              ),
              textRenderer: TextPaint(
                style: GoogleFonts.roboto(
                  textStyle: TextStyle(
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
        );
}
