import 'package:flutter/material.dart';

import '../components/card/gesture_detector_card.dart';
import '../components/score/score.dart';
import '../constants/routes.dart';
import '../utils/device_store.dart';
import '../utils/level.dart';
import 'base.dart';

class LevelsScreen extends StatefulWidget {
  const LevelsScreen({super.key});

  @override
  LevelsScreenState createState() => LevelsScreenState();
}

class LevelsScreenState extends State<LevelsScreen> {
// with RouteAware
  late Future<List<dynamic>> levelsFuture;
  late Future<Map<String, dynamic>> levelScores;

  @override
  void initState() {
    super.initState();
    _loadLevels();
  }

  // @override
  // void didPopNext() {
  //   setState(() {
  //     levelScores = DeviceStore.getLevelScores();
  //   });

  //   super.didPopNext();
  // }

  void _loadLevels() {
    setState(() {
      levelScores = DeviceStore.getLevelScores();
    });
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
                              FutureBuilder<Map<String, dynamic>>(
                                future: levelScores,
                                builder: (BuildContext context,
                                    AsyncSnapshot<Map<String, dynamic>>
                                        snapshot) {
                                  if (snapshot.connectionState ==
                                          ConnectionState.done &&
                                      snapshot.hasData) {
                                    return Score(
                                      score: (snapshot
                                                  .data?[(index + 1).toString()]
                                              as double?) ??
                                          0.0,
                                      starWidth: 20,
                                      starHeight: 20,
                                    );
                                  } else {
                                    return const CircularProgressIndicator();
                                  }
                                },
                              ),
                            ],
                          ),
                        ),
                      );
                      // );
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
