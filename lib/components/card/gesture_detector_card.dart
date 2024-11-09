import 'package:flutter/material.dart';

class GestureDetectorCard extends StatelessWidget {
  const GestureDetectorCard({
    super.key,
    required this.onTap,
    required this.child,
    this.cardMargin = const EdgeInsets.all(40.0),
  });

  final EdgeInsets cardMargin;
  final Future<void> Function() onTap;
  final Widget child;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Card(
        margin: cardMargin,
        color: Colors.orange,
        shadowColor: Colors.black,
        elevation: 5.0,
        child: child,
      ),
    );
  }
}
