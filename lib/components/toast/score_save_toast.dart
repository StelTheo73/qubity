import 'package:flutter/material.dart';
import 'package:toastification/toastification.dart';
import '../../components/text/roboto.dart';
import '../../constants/colors.dart';

class ScoreSaveToast {
  const ScoreSaveToast({
    required this.success,
    required this.message,
  });

  final bool success;
  final String message;

  void show() {
    toastification.show(
      closeOnClick: true,
      autoCloseDuration: Duration(seconds: success ? 5 : 15),
      showIcon: true,
      type: success ? ToastificationType.success : ToastificationType.error,
      style: ToastificationStyle.flatColored,
      title: RobotoText(
        text: success
            ? 'Your score has been saved successfully!'
            : 'Could not save score on database: ',
        fontSize: 14,
        color: Palette.black,
        fontWeight: FontWeight.bold,
      ),
      description: RobotoText(
        text: message,
        fontSize: 14,
        color: Palette.black,
      ),
      animationDuration: const Duration(milliseconds: 300),
      animationBuilder: (BuildContext context, Animation<double> animation,
              Alignment alignment, Widget child) =>
          FadeTransition(
        opacity: animation,
        child: child,
      ),
    );
  }
}
