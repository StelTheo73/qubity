import 'package:flutter/material.dart';

class GameExitAlert extends AlertDialog {
  const GameExitAlert({
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
    return AlertDialog(
      title: const Text('Exit Game'),
      content: const Text('Are you sure you want to exit the game?'),
      actions: <Widget>[
        TextButton(
          onPressed: () => onNo(context),
          child: const Text('No'),
        ),
        TextButton(
          onPressed: () => onYes(context),
          child: const Text('Yes'),
        ),
      ],
    );
  }
}
