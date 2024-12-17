import 'package:flutter/material.dart';

import '../components/card/gesture_detector_card.dart';
import '../components/score/score.dart';
import '../constants/routes.dart';
import '../state/level_score_notifier.dart';
import '../utils/level.dart';
import 'base.dart';

class LevelsScreen extends StatefulWidget {
  const LevelsScreen({super.key});

  @override
  LevelsScreenState createState() => LevelsScreenState();
}

class LevelsScreenState extends State<LevelsScreen> {
  late Future<List<dynamic>> levelsFuture;

  @override
  void initState() {
    super.initState();
    _loadLevels();
  }

  void _loadLevels() {
    setState(() {
      levelsFuture = LevelLoader.loadLevels();
    });
  }

  @override
  Widget build(BuildContext context) {
    return BaseScreen(
      title: 'Levels',
      body: FutureBuilder<List<dynamic>>(
        future: levelsFuture,
        builder: (
          BuildContext context,
          AsyncSnapshot<List<dynamic>> snapshot,
        ) {
          if (snapshot.hasData) {
            return Column(
              children: <Widget>[
                Expanded(
                  child: GridView.builder(
                    gridDelegate:
                        const SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 2,
                      crossAxisSpacing: 10.0,
                      mainAxisSpacing: 10.0,
                    ),
                    itemCount: snapshot.data!.length,
                    itemBuilder: (BuildContext context, int index) {
                      return GestureDetectorCard(
                        onTap: () async {
                          Navigator.pushNamed(
                            context,
                            AppRoute.game.route,
                            arguments: snapshot.data![index],
                          );
                        },
                        child: Padding(
                          padding: const EdgeInsets.all(3.0),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: <Widget>[
                              Text(
                                'Level ${index + 1}',
                                style: const TextStyle(
                                  fontSize: 20,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.all(10.0),
                                child: Text(snapshot.data![index]['description']
                                    as String),
                              ),
                              ListenableBuilder(
                                listenable: levelScoreNotifier,
                                builder: (BuildContext context, Widget? child) {
                                  return Score(
                                    score: levelScoreNotifier.getLevelScore(
                                        snapshot.data![index]['id'] as int),
                                    starWidth: 20,
                                    starHeight: 20,
                                  );
                                },
                              ),
                            ],
                          ),
                        ),
                      );
                    },
                  ),
                ),
              ],
            );
          }
          return const Center(
            child: CircularProgressIndicator(),
          );
        },
      ),
    );
  }
}
