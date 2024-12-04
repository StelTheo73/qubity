import 'dart:async';

import 'package:flame/components.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:qartvm/qartvm.dart';

import '../../constants/colors.dart';
import '../game.dart';
import '../state/level_state.dart';
import 'sprites.dart';

class RegisterComponent extends RectangleComponent with HasGameRef<QubityGame> {
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
  final List<RectangleComponent> cableComponents =
      List<RectangleComponent>.empty(growable: true);
  final List<RectangleComponent> gatesDefault =
      List<RectangleComponent>.empty(growable: true);
  final List<RectangleComponent> gatesHighlight =
      List<RectangleComponent>.empty(growable: true);
  final List<TextBoxComponent<TextPaint>> circuitLabels =
      List<TextBoxComponent<TextPaint>>.empty(growable: true);

  final Paint gatePaintDefault = Paint()..color = AppColors.primary;
  final Paint gatePaintHighlight = Paint()..color = AppColors.secondary;

  @override
  Future<void> onLoad() async {
    final String text = LevelStates.getRegisterText(register);
    textComponent = _getTextComponent(text);
    cableComponents.addAll(_getCableComponents());

    addAll(<Component>[
      textComponent,
      ...cableComponents,
    ]);

    super.onLoad();
  }

  void updateRegister() {
    final String text = LevelStates.getRegisterText(register);
    textComponent.text = text;
  }

  void highlightCircuitGates() {
    for (int i = 0; i < cableComponents.length; i++) {
      final RectangleComponent cableComponent = cableComponents[i];
      final RectangleComponent gateDefault = gatesDefault[i];
      final RectangleComponent gateHighlight = gatesHighlight[i];

      if (cableComponent.children.contains(gateDefault)) {
        cableComponent.remove(gateDefault);
      }
      cableComponent.add(gateHighlight);
    }
  }

  void resetCircuitGates() {
    for (int i = 0; i < cableComponents.length; i++) {
      final RectangleComponent cableComponent = cableComponents[i];
      final RectangleComponent gateDefault = gatesDefault[i];
      final RectangleComponent gateHighlight = gatesHighlight[i];

      if (cableComponent.children.contains(gateHighlight)) {
        cableComponent.remove(gateHighlight);
      }

      cableComponent.add(gateDefault);
    }
  }

  TextBoxComponent<TextPaint> _getTextComponent(String text) {
    return TextBoxComponent<TextPaint>(
      text: text,
      align: Anchor.center,
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

  List<RectangleComponent> _getCableComponents() {
    final List<RectangleComponent> cableComponents =
        List<RectangleComponent>.empty(growable: true);
    final List<double> positionX = List<double>.empty(growable: true);
    final List<String> labels = List<String>.empty(growable: true);

    labels.add('1st bit');
    if (register.size == 2) {
      positionX.add(size.x * 0.2);
      positionX.add(size.x * 0.8);
      labels.add('2nd bit');
    } else {
      positionX.add(size.x * 0.5);
    }

    for (int i = 0; i < positionX.length; i++) {
      final RectangleComponent rectangleComponent = _getCableComponent(
        positionX[i],
        labels[i],
      );
      cableComponents.add(rectangleComponent);
    }

    return cableComponents;
  }

  RectangleComponent _getCableComponent(double positionX, String label) {
    final Vector2 componentSize = Vector2(10, size.y * 1.5);

    final RectangleComponent rectangleComponent = RectangleComponent(
      size: componentSize,
      anchor: Anchor.topCenter,
      position: Vector2(positionX, size.y),
      paint: Paint()..color = (AppColors.primary).withOpacity(0.8),
    );

    circuitLabels.add(_getCableComponentLabel(componentSize, label));
    gatesDefault.add(_getGateComponent(componentSize, gatePaintDefault));
    gatesHighlight.add(_getGateComponent(componentSize, gatePaintHighlight));

    rectangleComponent.add(circuitLabels.last);
    rectangleComponent.add(gatesDefault.last);

    return rectangleComponent;
  }

  RectangleComponent _getGateComponent(
      Vector2 cableComponentSize, Paint gatePaint) {
    final Vector2 gateComponentSize = Vector2(size.y * 0.8, size.y * 0.8);

    return RectangleComponent(
      size: gateComponentSize,
      anchor: Anchor.center,
      position: Vector2(
        cableComponentSize.x / 2,
        cableComponentSize.y / 2,
      ),
      paint: gatePaint,
      children: <Component>[
        RectangleComponent(
          size: gateComponentSize,
          paint: gatePaint,
          anchor: Anchor.topLeft,
        ),
        SpriteComponent(
          sprite: SpriteIcons.add,
          size: gateComponentSize,
          anchor: Anchor.topLeft,
        ),
      ],
    );
  }

  TextBoxComponent<TextPaint> _getCableComponentLabel(
      Vector2 cableComponentSize, String label) {
    return TextBoxComponent<TextPaint>(
      text: label,
      anchor: Anchor.topCenter,
      align: Anchor.center,
      position: Vector2(cableComponentSize.x / 2, cableComponentSize.y),
      boxConfig: const TextBoxConfig(
        margins: EdgeInsets.zero,
      ),
      size: Vector2(50, 10),
      textRenderer: TextPaint(
        style: GoogleFonts.roboto(
          textStyle: const TextStyle(
            overflow: TextOverflow.visible,
            color: AppColors.white,
            fontSize: 10.0,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
    );
  }
}
