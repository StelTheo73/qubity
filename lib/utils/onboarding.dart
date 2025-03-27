import 'package:yaml/yaml.dart';

import '../constants/assets.dart';
import '../store/locale_notifier.dart';
import '../store/onboarding_notifier.dart';
import 'utils.dart';

class Onboarding {
  static Future<void> init() async {
    final YamlMap onboardingYaml = await Utils.loadYamlMap(onboardingPath);
    final String language = localeNotifier.locale.languageCode;

    final List<Map<String, String>> slides =
        (onboardingYaml['slides'][language] as YamlList).value.map((
          dynamic slide,
        ) {
          final YamlMap slideMap = slide as YamlMap;
          return <String, String>{
            'title': slideMap['title'] as String,
            'description': slideMap['description'] as String,
          };
        }).toList();

    onboardingNotifier.setOnboardingMap(slides);
  }
}
