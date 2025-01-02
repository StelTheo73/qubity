import 'package:flutter/material.dart';

import '../../store/current_score_notifier.dart';
import '../../store/level_score_notifier.dart';
import 'star.dart';

mixin _ScoreMixin {
  double get starWidth;
  double get starHeight;

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
}

class LevelCardScore extends StatelessWidget with _ScoreMixin {
  const LevelCardScore({
    super.key,
    required this.levelId,
    this.starWidth = 25,
    this.starHeight = 25,
  });

  final int levelId;
  @override
  final double starWidth;
  @override
  final double starHeight;

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

class LevelCompletionScore extends StatelessWidget with _ScoreMixin {
  const LevelCompletionScore({
    super.key,
    this.starWidth = 60,
    this.starHeight = 60,
  });

  @override
  final double starWidth;
  @override
  final double starHeight;

  @override
  Widget build(BuildContext context) {
    return ListenableBuilder(
      listenable: currentScoreNotifier,
      builder: (BuildContext context, Widget? child) {
        return Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: _getStars(
            currentScoreNotifier.currentScore,
          ),
        );
      },
    );
  }
}
