import 'package:flutter/material.dart';

import '../../state/level_score_notifier.dart';
import 'star.dart';

class Score extends StatelessWidget {
  const Score({
    super.key,
    required this.starWidth,
    required this.starHeight,
    required this.levelId,
  });

  final int levelId;
  final double starWidth;
  final double starHeight;

  List<Widget> _getStars(double score) {
    final List<Widget> stars = <Widget>[];

    final int fullStars = score ~/ 1;
    final int halfStar = (score % 1).ceil();
    final int emptyStars = 3 - fullStars - halfStar;

    for (int i = 0; i < fullStars; i++) {
      stars.add(FullStar(
        width: starWidth,
        height: starHeight,
      ));
    }

    if (halfStar == 1) {
      stars.add(HalfStar(
        width: starWidth,
        height: starHeight,
      ));
    }

    for (int i = 0; i < emptyStars; i++) {
      stars.add(EmptyStar(
        width: starWidth,
        height: starHeight,
      ));
    }

    return stars;
  }

  @override
  Widget build(BuildContext context) {
    return ListenableBuilder(
      listenable: levelScoreNotifier,
      builder: (BuildContext context, Widget? child) {
        return Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: _getStars(
            levelScoreNotifier.getLevelScore(levelId),
          ),
        );
      },
    );
  }
}
