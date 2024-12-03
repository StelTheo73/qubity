import 'dart:async';

import 'package:flame/components.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:qartvm/qartvm.dart';

import '../../constants/colors.dart';
import '../state/level_state.dart';

class RegisterComponent extends RectangleComponent {
  RegisterComponent(this.gameSize, this.register)
      : super(
          size: Vector2(gameSize.x * 0.4, 50),
          anchor: Anchor.centerLeft,
          position: Vector2(gameSize.x * 0.05, gameSize.y * 0.7),
          paint: Paint()..color = AppColors.primary,
        );

  final Vector2 gameSize;
  final QRegister register;
  late TextBoxComponent<TextPaint> textComponent;
  late List<RectangleComponent> circuitComponents;

  @override
  Future<void> onLoad() async {
    final String text = LevelStates.getRegisterText(register);
    textComponent = _getTextComponent(text);
    circuitComponents = _getCircuitComponents();

    addAll(<Component>[
      textComponent,
      ...circuitComponents,
    ]);

    super.onLoad();
  }

  void updateRegister() {
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
            color: AppColors.white,
            fontSize: 14.0,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
    );
  }

  List<RectangleComponent> _getCircuitComponents() {
    final List<RectangleComponent> circuitComponents =
        List<RectangleComponent>.empty(growable: true);
    final List<double> positionX = List<double>.empty(growable: true);

    if (register.size == 2) {
      positionX.add(size.x * 0.2);
      positionX.add(size.x * 0.8);
    } else {
      positionX.add(size.x * 0.5);
    }

    for (final double x in positionX) {
      final RectangleComponent rectangleComponent = _getCircuitComponent(x);
      circuitComponents.add(rectangleComponent);
    }

    return circuitComponents;
  }

  RectangleComponent _getCircuitComponent(double positionX) {
    final Vector2 componentSize = Vector2(10, size.y * 2);

    final RectangleComponent rectangleComponent = RectangleComponent(
      size: componentSize,
      anchor: Anchor.topCenter,
      position: Vector2(positionX, size.y),
      paint: Paint()..color = (AppColors.primary).withOpacity(0.8),
    );

    return rectangleComponent;
  }
}
