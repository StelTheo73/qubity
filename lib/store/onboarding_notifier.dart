import 'package:flutter/foundation.dart';

import '../utils/device_store.dart';

class OnboardingNotifier extends ChangeNotifier {
  final List<Map<String, String>> _onboardingMap = <Map<String, String>>[];
  bool _isOnboardingCompleted = false;

  List<Map<String, String>> get onboardingMap => _onboardingMap;
  bool get isOnboardingCompleted => _isOnboardingCompleted;

  Future<void> init() async {
    _isOnboardingCompleted = await DeviceStore.getOnboardingCompleted();
    notifyListeners();
  }

  void setOnboardingMap(List<Map<String, String>> onboardingMap) {
    _onboardingMap.clear();
    _onboardingMap.addAll(onboardingMap);
    notifyListeners();
  }

  void setOnboardingCompleted(bool isOnboardingCompleted) {
    _isOnboardingCompleted = isOnboardingCompleted;
    notifyListeners();
  }

  void resetState() {
    _onboardingMap.clear();
    _isOnboardingCompleted = false;
    notifyListeners();
  }
}

final OnboardingNotifier onboardingNotifier = OnboardingNotifier();
