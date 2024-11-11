import 'package:flutter/material.dart';
import 'package:yaml/yaml.dart';

import 'constants/routes.dart';
import 'screens/game.dart';
import 'screens/home.dart';
import 'screens/levels.dart';
import 'screens/settings.dart';
import 'screens/spaceships.dart';
import 'utils/config.dart';
import 'utils/device_store.dart';
import 'utils/level.dart';
import 'utils/utils.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  Utils.init();
  await DeviceStore.init();
  await Configuration.init();
  await LevelLoader.init();

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

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
        AppRoute.spaceships.route: (BuildContext context) => SpaceshipsScreen(),
        AppRoute.settings.route: (BuildContext context) => SettingsScreen()
      },
    );
  }
}
