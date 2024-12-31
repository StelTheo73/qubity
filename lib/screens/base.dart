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
    this.onBackButtonPressed,
  });

  final Widget body;
  final bool showBackButton;
  final String title;
  final bool hasBackground;
  final void Function()? onBackButtonPressed;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(
        title: title,
        showBackButton: showBackButton,
        onBackButtonPressed: onBackButtonPressed,
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
