import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:toastification/toastification.dart';
import 'package:yaml/yaml.dart';

import 'api/db_client.dart';
import 'constants/routes.dart';
import 'l10n/app_localizations.dart';
import 'screens/game.dart';
import 'screens/home.dart';
import 'screens/levels.dart';
import 'screens/quiz/quiz.dart';
import 'screens/quiz/quiz_history.dart';
import 'screens/quiz/quiz_menu.dart';
import 'screens/settings.dart';
import 'screens/spaceships.dart';
import 'screens/tutorial/tutorial.dart';
import 'store/level_score_notifier.dart';
import 'store/locale_notifier.dart';
import 'utils/config.dart';
import 'utils/device_store.dart';
import 'utils/level.dart';
import 'utils/utils.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  Utils.init();
  await Utils.exitFullScreen();
  await Configuration.init();
  await DeviceStore.init();
  await LevelLoader.init();
  await DatabaseClient.init();

  await Future.wait(<Future<void>>[
    localeNotifier.init(),
    levelScoreNotifier.init(),
  ]);

  runApp(const QubityApp());
}

class QubityApp extends StatelessWidget {
  const QubityApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ListenableBuilder(
      listenable: localeNotifier,
      builder: (BuildContext context, Widget? child) {
        return ToastificationWrapper(
          child: MaterialApp(
            debugShowCheckedModeBanner: false,
            title: Configuration.appName,
            locale: localeNotifier.locale,
            // ignore: strict_raw_type, always_specify_types
            localizationsDelegates: const <LocalizationsDelegate>[
              AppLocalizations.delegate,
              GlobalMaterialLocalizations.delegate,
              GlobalWidgetsLocalizations.delegate,
              GlobalCupertinoLocalizations.delegate,
            ],
            supportedLocales: AppLocalizations.supportedLocales,
            routes: <String, WidgetBuilder>{
              AppRoute.game.route: (BuildContext context) {
                final YamlMap level =
                    ModalRoute.of(context)!.settings.arguments! as YamlMap;
                return GameScreen(initialLevel: level);
              },
              AppRoute.home.route: (BuildContext context) => const HomeScreen(),
              AppRoute.levels.route: (BuildContext context) =>
                  const LevelsScreen(),
              AppRoute.quiz.route: (BuildContext context) => const QuizScreen(),
              AppRoute.quizMenu.route: (BuildContext context) =>
                  const QuizMenuScreen(),
              AppRoute.quizHistory.route: (BuildContext context) =>
                  const QuizHistoryScreen(),
              AppRoute.spaceships.route: (BuildContext context) =>
                  const SpaceshipsScreen(),
              AppRoute.settings.route: (BuildContext context) =>
                  const SettingsScreen(),
              AppRoute.tutorial.route: (BuildContext context) {
                final YamlMap level =
                    ModalRoute.of(context)!.settings.arguments! as YamlMap;
                return TutorialScreen(tutorialLevel: level);
              }
            },
          ),
        );
      },
    );
  }
}
