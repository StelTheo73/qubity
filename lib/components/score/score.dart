import 'package:flutter/material.dart';

import 'star.dart';

class Score extends StatelessWidget {
  const Score({
    super.key,
    required this.score,
    required this.starWidth,
    required this.starHeight,
  });

  final double score;
  final double starWidth;
  final double starHeight;

  List<Widget> _getStars() {
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
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: _getStars(),
    );
  }
}
