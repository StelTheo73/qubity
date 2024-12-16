import 'package:flutter/material.dart';

import '../../constants/colors.dart';
import '../text/roboto.dart';

class LevelExitAlert extends AlertDialog {
  const LevelExitAlert({
    super.key,
  });

  void onNo(BuildContext context) {
    Navigator.of(context).pop(false);
  }

  void onYes(BuildContext context) {
    Navigator.of(context).pop(true);
  }

  @override
  Widget build(BuildContext context) {
    const Color color = Palette.black;

    return AlertDialog(
      title: const RobotoText(
        text: 'Exit Level',
        fontSize: 22,
        fontWeight: FontWeight.bold,
        color: color,
      ),
      content: const RobotoText(
        text: 'Are you sure you want to return to level selection?',
        color: color,
        fontSize: 14,
      ),
      actions: <Widget>[
        TextButton(
          onPressed: () => onYes(context),
          child: const RobotoText(
            text: 'Exit Level',
            fontSize: 14,
            color: color,
          ),
        ),
        TextButton(
          onPressed: () => onNo(context),
          child: const RobotoText(
            text: 'Continue Playing',
            fontSize: 14,
          ),
        ),
      ],
    );
  }
}
