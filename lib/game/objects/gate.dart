import 'package:flame/components.dart';
import 'package:flame/events.dart';
import 'package:flutter/material.dart';

import '../../constants/colors.dart';
import '../../constants/gates.dart';
import '../game.dart';
import '../game_utils.dart';

class GateComponent extends RectangleComponent
    with HasGameRef<QubityGame>, TapCallbacks {
  GateComponent(this.gate, this.positionX, this.positionY)
      : super(size: GateComponent.componentSize);

  @override
  final Anchor anchor = Anchor.center;
  static final Vector2 componentSize = Vector2(50, 50);

  late final String spriteImagePath;
  final Gate gate;
  double positionX;
  double positionY;

  final Paint defaultPaint = Paint()..color = Palette.primary.withOpacity(0.4);
  final Paint selectedPaint = Paint()..color = Palette.secondary;

  @override
  Future<void> onLoad() async {
    await super.onLoad();

    x = positionX;
    y = positionY;
    anchor = Anchor.center;
    paint = defaultPaint;

    spriteImagePath =
        GameUtils.extractImagePath(gatesMap[gate]!['image']! as String);
    final Sprite sprite = await gameRef.loadSprite(spriteImagePath);

    final RectangleComponent spriteBackground = RectangleComponent(
      size: Vector2(size.x * 0.8, size.y * 0.8),
      paint: Paint()..color = Palette.primary,
      anchor: Anchor.center,
      position: Vector2(size.x / 2, size.y / 2),
    );
    final SpriteComponent gateSprite = SpriteComponent(
      sprite: sprite,
      size: size,
      anchor: Anchor.topLeft,
    );

    add(spriteBackground);
    add(gateSprite);
  }

  void select() {
    paint = selectedPaint;
  }

  void deselect() {
    paint = defaultPaint;
  }

  @override
  void onTapUp(TapUpEvent event) {
    gameRef.selectGate(this);
    super.onTapUp(event);
  }
}
