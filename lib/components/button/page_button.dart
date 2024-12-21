import 'package:flutter/material.dart';

import 'base_button.dart';

class PageButton extends StatelessWidget {
  const PageButton({
    super.key,
    required this.buttonText,
    required this.navigateTo,
    this.icon,
  });

  final String buttonText;
  final String navigateTo;
  final IconData? icon;

  @override
  Widget build(BuildContext context) {
    return BaseButton(
      onPressed: () {
        Navigator.pushNamed(context, navigateTo);
      },
      text: buttonText,
      width: MediaQuery.of(context).size.width * 0.75,
      icon: icon,
      mainAxisAlignment: MainAxisAlignment.start,
    );
  }
}
