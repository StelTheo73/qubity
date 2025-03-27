import 'package:flutter/material.dart';

import '../../constants/colors.dart';
import '../../l10n/app_localizations.dart';
import '../../store/onboarding_notifier.dart';
import '../../utils/device_store.dart';
import '../button/base_button.dart';
import '../text/roboto.dart';
import 'base_overlay.dart';

class OnboardingWidget extends StatelessWidget {
  const OnboardingWidget({
    super.key,
    required this.title,
    required this.description,
  });

  final String title;
  final String description;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(10),
      child: Column(
        children: <Widget>[
          RobotoText(text: title, fontSize: 20, fontWeight: FontWeight.bold),
          const SizedBox(height: 10),
          RobotoText(text: description, fontSize: 16, color: Palette.black),
        ],
      ),
    );
  }
}

class OnboardingOverlay extends StatefulWidget {
  const OnboardingOverlay({super.key});

  @override
  State<StatefulWidget> createState() => _OnboardingOverlayState();
}

class _OnboardingOverlayState extends State<OnboardingOverlay> {
  ValueNotifier<int> indexNotifier = ValueNotifier<int>(0);
  int index = 0;
  late Widget visibleChild;
  late bool showStartButton;
  late bool showPreviousButton;

  static const double buttonWidth = 150;

  @override
  void initState() {
    super.initState();

    setState(() {
      showStartButton = (onboardingNotifier.onboardingMap.length == 1);
      showPreviousButton = false;

      visibleChild = ValueListenableBuilder<int>(
        valueListenable: indexNotifier,
        builder: (BuildContext context, int index, Widget? child) {
          return ListenableBuilder(
            listenable: onboardingNotifier,
            builder: (BuildContext context, Widget? child) {
              return OnboardingWidget(
                title: onboardingNotifier.onboardingMap[index]['title'] ?? '',
                description:
                    onboardingNotifier.onboardingMap[index]['description'] ??
                    '',
              );
            },
          );
        },
      );
    });
  }

  void _loadPreviousSlide() {
    setState(() {
      if (indexNotifier.value == 0) {
        return;
      }
      indexNotifier.value = indexNotifier.value - 1;

      if (indexNotifier.value == 0) {
        showPreviousButton = false;
      }

      if (indexNotifier.value < onboardingNotifier.onboardingMap.length - 1) {
        showStartButton = false;
      }
    });
  }

  void _loadNextSlide() {
    setState(() {
      indexNotifier.value = indexNotifier.value + 1;
      showPreviousButton = true;
      if (indexNotifier.value == onboardingNotifier.onboardingMap.length - 1) {
        showStartButton = true;
      }
    });
  }

  void _completeOnboarding() {
    DeviceStore.setOnboardingCompleted();
    onboardingNotifier.setOnboardingCompleted(true);
    Navigator.of(context).pop();
  }

  @override
  Widget build(BuildContext context) {
    return BaseOverlay(
      children: <Widget>[
        visibleChild,
        const SizedBox(height: 10),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: <Widget>[
            if (showPreviousButton)
              BaseButton(
                onPressed: _loadPreviousSlide,
                text: AppLocalizations.of(context)!.previous,
                width: buttonWidth,
                color: Palette.grey,
                icon: Icons.arrow_back,
              )
            else
              const SizedBox(width: buttonWidth),
            if (showStartButton)
              BaseButton(
                onPressed: _completeOnboarding,
                text: AppLocalizations.of(context)!.startGame,
                width: buttonWidth,
              )
            else
              BaseButton(
                onPressed: _loadNextSlide,
                text: AppLocalizations.of(context)!.next,
                width: buttonWidth,
                icon: Icons.arrow_forward,
              ),
          ],
        ),
      ],
    );
  }
}
