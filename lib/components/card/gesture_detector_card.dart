import 'package:flutter/material.dart';

class GestureDetectorCard extends StatelessWidget {
  const GestureDetectorCard({
    super.key,
    required this.child,
    this.onTap,
    this.disabled = false,
    this.cardMargin = const EdgeInsets.all(40.0),
  });

  final EdgeInsets cardMargin;
  final Future<void> Function()? onTap;
  final Widget child;
  final bool disabled;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Card(
        margin: cardMargin,
        color: disabled ? Colors.orange.withOpacity(0.6) : Colors.orange,
        shadowColor: Colors.black,
        elevation: 5.0,
        child: child,
      ),
    );
  }
}
