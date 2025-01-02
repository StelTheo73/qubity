import 'package:flutter/material.dart';

import '../utils/config.dart';
import '../utils/device_store.dart';

class LocaleNotifier extends ChangeNotifier {
  Locale _locale = Locale(Configuration.defaultLanguage);

  Locale get locale => _locale;

  void setLocale(String locale) {
    _locale = Locale(locale);
    notifyListeners();
  }

  Future<void> init() async {
    final String language = await DeviceStore.getLanguage();
    _locale = Locale(language);
    notifyListeners();
  }

  void resetState() {
    _locale = Locale(Configuration.defaultLanguage);
    notifyListeners();
  }
}

final LocaleNotifier localeNotifier = LocaleNotifier();
