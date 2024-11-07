import 'package:flutter/material.dart';

import 'utils/level.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await LevelLoader.init();

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
    );
  }
}
