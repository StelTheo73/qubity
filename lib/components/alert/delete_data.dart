import 'package:flutter/material.dart';

import '../../constants/colors.dart';
import '../../l10n/app_localizations.dart';
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
          title: RobotoText(
            text: AppLocalizations.of(context)!.deleteGameDataHeader,
            fontSize: 22,
            fontWeight: FontWeight.bold,
            color: Palette.danger,
          ),
          content: RobotoText(
            text: AppLocalizations.of(context)!.deleteGameDataConfirmation,
            color: Palette.black,
            fontSize: 14,
          ),
          actions: <Widget>[
            BaseButton(
              onPressed: () => onYes(context),
              color: Palette.danger,
              text: AppLocalizations.of(context)!.delete,
              fontSize: 14,
              width: 115,
            ),
            BaseButton(
              onPressed: () => onNo(context),
              text: AppLocalizations.of(context)!.cancel,
              fontSize: 14,
              color: Palette.white,
              width: 115,
            ),
          ],
        ),
      ],
    );
  }
}
