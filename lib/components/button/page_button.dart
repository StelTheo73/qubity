import 'package:flutter/material.dart';

import 'base_button.dart';

class PageButton extends StatelessWidget {
  const PageButton({
    super.key,
    required this.buttonText,
    required this.navigateTo,
    this.onPressed,
    this.navigateArguments,
    this.icon,
    this.textAlignment = MainAxisAlignment.start,
  });

  final String buttonText;
  final String navigateTo;
  final Future<void> Function()? onPressed;
  final IconData? icon;
  final Object? navigateArguments;
  final MainAxisAlignment textAlignment;

  @override
  Widget build(BuildContext context) {
    return BaseButton(
      onPressed: () async {
        await onPressed?.call();
        if (context.mounted) {
          Navigator.pushNamed(
            context,
            navigateTo,
            arguments: navigateArguments,
          );
        }
      },
      text: buttonText,
      width: MediaQuery.of(context).size.width * 0.75,
      icon: icon,
      mainAxisAlignment: textAlignment,
    );
  }
}
