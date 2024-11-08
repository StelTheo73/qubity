import 'package:flutter/material.dart';
import 'package:yaml/yaml.dart';

import 'constants/routes.dart';
import 'screens/game.dart';
import 'screens/home.dart';
import 'screens/levels.dart';
import 'screens/settings.dart';
import 'utils/config.dart';
import 'utils/level.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await Configuration.init();
  await LevelLoader.init();

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: Configuration.appName,
      routes: <String, WidgetBuilder>{
        AppRoute.home.route: (BuildContext context) => const HomeScreen(),
        AppRoute.game.route: (BuildContext context) {
          final YamlMap level =
              ModalRoute.of(context)!.settings.arguments! as YamlMap;
          return GameScreen(level: level);
        },
        AppRoute.levels.route: (BuildContext context) => const LevelsScreen(),
        AppRoute.settings.route: (BuildContext context) => SettingsScreen()
      },
    );
  }
}
