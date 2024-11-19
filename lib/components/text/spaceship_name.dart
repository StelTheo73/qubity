import 'package:flutter/material.dart';

import 'roboto.dart';

class SpaceshipNameText extends StatelessWidget {
  const SpaceshipNameText({required this.name, super.key});

  final String name;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 100,
      height: 40,
      alignment: Alignment.center,
      child: TextRoboto(
        text: name,
        fontSize: 14,
        fontWeight: FontWeight.bold,
        textAlign: TextAlign.center,
        overflow: TextOverflow.visible,
      ),
    );
  }
}
