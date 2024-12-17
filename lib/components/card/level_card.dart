import 'package:flutter/material.dart';
import 'package:yaml/yaml.dart';

import '../../constants/colors.dart';
import '../../constants/routes.dart';
import '../../utils/level.dart';
import '../score/score.dart';
import '../text/roboto.dart';
import 'gesture_detector_card.dart';

class GatesWidget extends StatelessWidget {
  const GatesWidget({super.key, required this.gates});

  final List<String> gates;

  @override
  Widget build(BuildContext context) {
    final String text = 'Gates: ${gates.join(', ')}';

    return RobotoText(
      text: text,
      color: Palette.black,
      fontSize: 14,
    );
  }
}

class LevelCard extends StatelessWidget {
  const LevelCard({super.key, required this.level});

  final YamlMap level;

  @override
  Widget build(BuildContext context) {
    final int levelId = level['id'] as int;
    final int noOfQubits = (level['initial'] as YamlList).length;
    final List<String> levelGates =
        LevelLoader.getLevelGates(level).value.map((dynamic gate) {
      return gate as String;
    }).toList();

    return GestureDetectorCard(
      onTap: () async {
        Navigator.pushNamed(
          context,
          AppRoute.game.route,
          arguments: level,
        );
      },
      child: Padding(
        padding: const EdgeInsets.all(3.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[
            RobotoText(
              text: 'Level $levelId',
              color: Palette.black,
              fontSize: 20,
              fontWeight: FontWeight.bold,
            ),
            RobotoText(
              text: 'Qubits: $noOfQubits',
              color: Palette.black,
              fontSize: 14,
            ),
            GatesWidget(gates: levelGates),
            LevelCardScore(levelId: levelId),
          ],
        ),
      ),
    );
  }
}
