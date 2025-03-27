import 'package:flutter/material.dart';

import '../../constants/colors.dart';
import '../../l10n/app_localizations.dart';
import '../../store/onboarding_notifier.dart';
import '../../utils/device_store.dart';
import '../button/base_button.dart';
import '../text/roboto.dart';

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
      decoration: BoxDecoration(
        color: Palette.white,
        borderRadius: BorderRadius.circular(10),
        boxShadow: <BoxShadow>[
          BoxShadow(
            color: Palette.black.withOpacity(0.2),
            blurRadius: 10,
            spreadRadius: 5,
          ),
        ],
      ),
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

  static const String overlayKey = 'onboarding_overlay';
  static const int priority = 3;

  @override
  State<StatefulWidget> createState() => _OnboardingOverlayState();
}

class _OnboardingOverlayState extends State<OnboardingOverlay> {
  ValueNotifier<int> indexNotifier = ValueNotifier<int>(0);
  int index = 0;
  late Widget visibleChild;
  late bool showStartButton;

  @override
  void initState() {
    super.initState();

    setState(() {
      showStartButton = (onboardingNotifier.onboardingMap.length == 1);

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

  void _loadNextSlide() {
    setState(() {
      indexNotifier.value = indexNotifier.value + 1;
      if (indexNotifier.value == onboardingNotifier.onboardingMap.length - 1) {
        showStartButton = true;
      }
    });
  }

  void _completeOnboarding() {
    indexNotifier.value = 0;
    DeviceStore.setOnboardingCompleted();
    Navigator.of(context).pop();
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          visibleChild,
          const SizedBox(height: 10),
          if (showStartButton)
            BaseButton(
              onPressed: _completeOnboarding,
              text: AppLocalizations.of(context)!.startJourney,
              width: 200,
            )
          else
            BaseButton(
              onPressed: _loadNextSlide,
              text: AppLocalizations.of(context)!.next,
              width: 200,
            ),
        ],
      ),
    );
  }
}
