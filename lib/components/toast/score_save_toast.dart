import 'package:flutter/material.dart';
import 'package:toastification/toastification.dart';
import '../../components/text/roboto.dart';
import '../../constants/colors.dart';
import '../../l10n/app_localizations.dart';
import '../../store/locale_notifier.dart';

class ScoreSaveToast {
  const ScoreSaveToast({required this.success, required this.message});

  final bool success;
  final String message;

  Future<void> show() async {
    final AppLocalizations t = await AppLocalizations.delegate.load(
      Locale(localeNotifier.locale.languageCode),
    );
    final String title =
        success ? t.quizScoreSavedMessage : t.quizScoreErrorMessage;
    final int duration = success ? 5 : 15;
    final ToastificationType type =
        success ? ToastificationType.success : ToastificationType.error;

    toastification.show(
      closeOnClick: true,
      autoCloseDuration: Duration(seconds: duration),
      showIcon: true,
      type: type,
      style: ToastificationStyle.flatColored,
      title: RobotoText(
        text: title,
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
      animationBuilder:
          (
            BuildContext context,
            Animation<double> animation,
            Alignment alignment,
            Widget child,
          ) => FadeTransition(opacity: animation, child: child),
    );
  }
}
