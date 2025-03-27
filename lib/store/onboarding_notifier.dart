import 'package:flutter/foundation.dart';

class OnboardingNotifier extends ChangeNotifier {
  final List<Map<String, String>> _onboardingMap = <Map<String, String>>[];

  List<Map<String, String>> get onboardingMap => _onboardingMap;

  void setOnboardingMap(List<Map<String, String>> onboardingMap) {
    _onboardingMap.clear();
    _onboardingMap.addAll(onboardingMap);
    notifyListeners();
  }

  void resetState() {
    _onboardingMap.clear();
    notifyListeners();
  }
}

final OnboardingNotifier onboardingNotifier = OnboardingNotifier();
