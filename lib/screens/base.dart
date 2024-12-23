import 'package:flutter/material.dart';

import '../components/navbar/navbar.dart';
import '../constants/assets.dart';

class BaseScreen extends StatelessWidget {
  const BaseScreen({
    super.key,
    required this.title,
    required this.body,
    this.showBackButton = true,
    this.hasBackground = true,
  });

  final Widget body;
  final bool showBackButton;
  final String title;
  final bool hasBackground;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(
        title: title,
        showBackButton: showBackButton,
      ),
      body: Container(
        height: double.infinity,
        width: double.infinity,
        decoration: hasBackground
            ? const BoxDecoration(
                image: DecorationImage(
                  image: AssetImage(backgroundSmallScreenPath),
                  fit: BoxFit.cover,
                ),
              )
            : null,
        child: body,
      ),
    );
  }
}
