import 'package:flutter/material.dart';

import '../../constants/colors.dart';

class GestureDetectorCard extends StatelessWidget {
  const GestureDetectorCard({
    super.key,
    required this.child,
    this.onTap,
    this.opacity = false,
    this.cardMargin = const EdgeInsets.all(40.0),
  });

  final EdgeInsets cardMargin;
  final Future<void> Function()? onTap;
  final Widget child;
  final bool opacity;

  @override
  Widget build(BuildContext context) {
    const Color color = AppColors.secondary;
    final Color colorOpacity = opacity ? color.withOpacity(0.6) : color;

    return GestureDetector(
      onTap: onTap,
      child: Card(
        margin: cardMargin,
        color: colorOpacity,
        shadowColor: AppColors.black,
        elevation: 5.0,
        child: child,
      ),
    );
  }
}
