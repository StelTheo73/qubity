import 'package:flutter/material.dart';

import '../../constants/colors.dart';

class PageButton extends StatelessWidget {
  const PageButton({
    super.key,
    required this.buttonText,
    required this.navigateTo,
  });

  final String buttonText;
  final String navigateTo;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: MediaQuery.of(context).size.width * 0.75,
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(
          backgroundColor: Palette.secondary,
          foregroundColor: Palette.black,
        ),
        onPressed: () {
          Navigator.pushNamed(context, navigateTo);
        },
        child: Text(buttonText),
      ),
    );
  }
}
