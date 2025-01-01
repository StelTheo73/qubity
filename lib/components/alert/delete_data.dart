import 'package:flutter/material.dart';

import '../../constants/colors.dart';
import '../../utils/utils.dart';
import '../button/base_button.dart';
import '../text/roboto.dart';

class DeleteDataAlert extends StatelessWidget {
  const DeleteDataAlert({
    super.key,
  });

  static void show(BuildContext context) {
    showDialog<void>(
      context: context,
      builder: (BuildContext context) {
        return const DeleteDataAlert();
      },
    );
  }

  void onNo(BuildContext context) {
    Navigator.pop(context);
  }

  void onYes(BuildContext context) {
    Utils.resetGame();
    Navigator.pop(context);
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      mainAxisSize: MainAxisSize.min,
      children: <Widget>[
        AlertDialog(
          title: const RobotoText(
            text: 'Delete Game Data',
            fontSize: 22,
            fontWeight: FontWeight.bold,
            color: Palette.danger,
          ),
          content: const RobotoText(
            text: 'Are you sure you want to delete all game data?',
            color: Palette.black,
            fontSize: 14,
          ),
          actions: <Widget>[
            BaseButton(
              onPressed: () => onYes(context),
              color: Palette.danger,
              text: 'Delete',
              fontSize: 14,
              width: 100,
            ),
            BaseButton(
              onPressed: () => onNo(context),
              text: 'Cancel',
              fontSize: 14,
              color: Palette.white,
              width: 100,
            ),
          ],
        ),
      ],
    );
  }
}
