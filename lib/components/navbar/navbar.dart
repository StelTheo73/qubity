import 'package:flutter/material.dart';

import '../../constants/colors.dart';
import '../text/roboto.dart';

class CustomAppBar extends StatelessWidget implements PreferredSizeWidget {
  const CustomAppBar({
    super.key,
    required this.title,
    this.showBackButton = true,
  });
  final String title;
  final bool showBackButton;

  @override
  Widget build(BuildContext context) {
    return AppBar(
      leading: showBackButton
          ? IconButton(
              icon: const Icon(Icons.arrow_back),
              onPressed: () {
                Navigator.pop(context);
              },
            )
          : null,
      title: RobotoText(
        text: title,
        fontSize: 24,
        color: Palette.black,
        fontWeight: FontWeight.bold,
      ),
      backgroundColor: Palette.primary,
      shadowColor: Palette.black,
      elevation: 5.0,
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}
