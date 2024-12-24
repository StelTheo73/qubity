import 'package:flame/components.dart';
import 'package:flame/events.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:qartvm/qartvm.dart';

import '../../constants/colors.dart';
import '../qubity_game.dart';
import '../state/level_state.dart';
import 'sprites.dart';

class CircuitGateComponent extends RectangleComponent
    with HasGameRef<QubityGame>, TapCallbacks {
  CircuitGateComponent(
    this.qubitId,
    this.cableComponentSize,
    this.gateComponentSize,
    this.gatePaint,
  ) : super(
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
  final int qubitId;

  final Vector2 cableComponentSize;
  final Vector2 gateComponentSize;
  final Paint gatePaint;

  @override
  void onTapUp(TapUpEvent event) {
    if (!gameRef.running) {
      return;
    }

    gameRef.applyGate(qubitId);
    gameRef.increaseGatesUsed();
    gameRef.onTapUpCircuitGate(event);
    super.onTapUp(event);
  }
}

class RegisterComponent extends RectangleComponent with HasGameRef<QubityGame> {
  RegisterComponent(this.gameSize, this.register)
      : super(
          size: Vector2(gameSize.x * 0.4, 50),
          anchor: Anchor.centerLeft,
          position: Vector2(gameSize.x * 0.05, gameSize.y * 0.7),
          paint: Paint()..color = Palette.secondary,
        );

  final Vector2 gameSize;
  final QRegister register;
  final Paint gatePaintDefault = Paint()..color = Palette.secondary;
  final Paint gatePaintHighlight = Paint()..color = Palette.primary;

  late TextBoxComponent<TextPaint> textComponent;
  final List<RectangleComponent> cableComponents =
      List<RectangleComponent>.empty(growable: true);
  final List<CircuitGateComponent> gatesDefault =
      List<CircuitGateComponent>.empty(growable: true);
  final List<CircuitGateComponent> gatesHighlight =
      List<CircuitGateComponent>.empty(growable: true);
  final List<TextBoxComponent<TextPaint>> circuitLabels =
      List<TextBoxComponent<TextPaint>>.empty(growable: true);

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

  void highlightCircuitGates() {
    for (int i = 0; i < cableComponents.length; i++) {
      final RectangleComponent cableComponent = cableComponents[i];
      final CircuitGateComponent gateHighlight = gatesHighlight[i];
      cableComponent.add(gateHighlight);
    }
  }

  void resetCircuitGates() {
    for (int i = 0; i < cableComponents.length; i++) {
      final RectangleComponent cableComponent = cableComponents[i];
      final CircuitGateComponent gateHighlight = gatesHighlight[i];
      if (cableComponent.children.contains(gateHighlight)) {
        cableComponent.remove(gateHighlight);
      }
    }
  }

  void updateRegister() {
    final String text = LevelStates.getRegisterText(register);
    textComponent.text = text;
  }

  RectangleComponent _getCableComponent(
      int qubitId, double positionX, String label) {
    final Vector2 componentSize = Vector2(10, size.y * 1.5);

    final RectangleComponent cable = RectangleComponent(
      size: componentSize,
      anchor: Anchor.topCenter,
      position: Vector2(positionX, size.y),
      paint: Paint()..color = Palette.secondary.withOpacity(0.8),
    );

    circuitLabels.add(_getCableComponentLabel(componentSize, label));
    gatesDefault
        .add(_getGateComponent(qubitId, componentSize, gatePaintDefault));
    gatesHighlight
        .add(_getGateComponent(qubitId, componentSize, gatePaintHighlight));

    cable.add(circuitLabels.last);
    cable.add(gatesDefault.last);

    return cable;
  }

  TextBoxComponent<TextPaint> _getCableComponentLabel(
      Vector2 cableComponentSize, String label) {
    return TextBoxComponent<TextPaint>(
      text: label,
      anchor: Anchor.topCenter,
      align: Anchor.center,
      position: Vector2(cableComponentSize.x / 2, cableComponentSize.y + 5),
      boxConfig: const TextBoxConfig(
        margins: EdgeInsets.zero,
      ),
      size: Vector2(50, 10),
      textRenderer: TextPaint(
        style: GoogleFonts.roboto(
          textStyle: const TextStyle(
            overflow: TextOverflow.visible,
            color: Palette.white,
            fontSize: 10.0,
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

    // Assuming that the register size is 1 or 2
    if (register.size == 2) {
      positionX.add(size.x * 0.2);
      positionX.add(size.x * 0.8);
      labels.add('2nd qubit');
    } else {
      positionX.add(size.x * 0.5);
    }
    labels.add('1st qubit');

    for (int i = 0; i < positionX.length; i++) {
      final RectangleComponent cableComponent = _getCableComponent(
        positionX.length - 1 - i,
        positionX[i],
        labels[i],
      );
      cableComponents.add(cableComponent);
    }

    return cableComponents;
  }

  CircuitGateComponent _getGateComponent(
    int qubitId,
    Vector2 cableComponentSize,
    Paint gatePaint,
  ) {
    final Vector2 gateComponentSize = Vector2(size.y * 0.8, size.y * 0.8);

    return CircuitGateComponent(
      qubitId,
      cableComponentSize,
      gateComponentSize,
      gatePaint,
    );
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
            color: Palette.black,
            fontSize: 14.0,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
    );
  }
}
