import 'dart:async';

import 'package:flame/components.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:qartvm/qartvm.dart';

import '../state/level_state.dart';

class RegisterComponent extends RectangleComponent {
  RegisterComponent(this.gameSize, this.register)
      : super(
          size: Vector2(gameSize.x * 0.4, 50),
          anchor: Anchor.centerLeft,
          position: Vector2(gameSize.x * 0.05, gameSize.y * 0.7),
          paint: Paint()..color = Colors.purple,
        );

  final Vector2 gameSize;
  QRegister register;
  late TextBoxComponent<TextPaint> textComponent;

  @override
  Future<void> onLoad() async {
    final String text = LevelStates.getRegisterText(register);
    textComponent = _getTextComponent(text);
    add(textComponent);
    super.onLoad();
  }

  void updateRegister(QRegister newRegister) {
    register = newRegister;
    final String text = LevelStates.getRegisterText(register);
    textComponent.text = text;
  }

  TextBoxComponent<TextPaint> _getTextComponent(String text) {
    return TextBoxComponent<TextPaint>(
      text: text,
      anchor: Anchor.center,
      position: Vector2(size.x / 2, size.y / 2),
      size: size,
      textRenderer: TextPaint(
        style: GoogleFonts.roboto(
          textStyle: const TextStyle(
            color: Colors.white,
            fontSize: 14.0,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
    );
  }
}
