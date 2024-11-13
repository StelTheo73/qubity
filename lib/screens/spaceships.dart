import 'package:flutter/material.dart';

import '../components/card/spaceship_card.dart';
import '../constants/spaceships.dart';
import '../state/spaceship_notifier.dart';
import '../utils/level.dart';
import '../utils/spaceship.dart';
import 'base.dart';

class SpaceshipsScreen extends StatefulWidget {
  const SpaceshipsScreen({super.key});

  @override
  _SpaceshipsScreenState createState() => _SpaceshipsScreenState();
}

class _SpaceshipsScreenState extends State<SpaceshipsScreen> {
  late Future<List<dynamic>> futures;
  final SpaceshipNotifier spaceshipNotifier = SpaceshipNotifier();

  @override
  void initState() {
    super.initState();
    futures = Future.wait(<Future<dynamic>>[
      LevelLoader.getLastUnlockedLevel(),
      SpaceshipLoader.getSelectedSpaceshipId(),
    ]);
  }

  @override
  Widget build(BuildContext context) {
    return BaseScreen(
      title: 'Select a Spaceship',
      body: FutureBuilder<List<dynamic>>(
        future: futures,
        builder: (BuildContext context, AsyncSnapshot<List<dynamic>> snapshot) {
          if (snapshot.hasData) {
            final int currentLevel = snapshot.data![0] as int;
            final String selectedSpaceshipId = snapshot.data![1] as String;
            spaceshipNotifier.setSelectedSpaceshipId(selectedSpaceshipId);

            return Column(
              children: <Widget>[
                const SizedBox(
                  height: 40,
                ),
                Expanded(
                  child: GridView.builder(
                    gridDelegate:
                        const SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 2,
                    ),
                    itemCount: spaceships.length,
                    itemBuilder: (BuildContext context, int index) {
                      final String spaceshipKey =
                          spaceships.keys.elementAt(index);
                      final Map<String, dynamic> spaceship =
                          spaceships[spaceshipKey]!;
                      final String spaceshipName = spaceship['name'] as String;
                      final String imagePath = spaceship['image'] as String;
                      final int unlockLevel = spaceship['level'] as int;

                      if (currentLevel < unlockLevel) {
                        return LockedSpaceship(
                          spaceshipName: spaceshipName,
                          imagePath: imagePath,
                        );
                      }
                      return UnlockedSpaceShip(
                        spaceshipName: spaceshipName,
                        spaceShipId: spaceshipKey,
                        imagePath: imagePath,
                        spaceshipNotifier: spaceshipNotifier,
                      );
                    },
                  ),
                ),
              ],
            );
          } else {
            if (snapshot.hasError) {
              return Center(
                child: Text('Error: ${snapshot.error}'),
              );
            }
            return const Center(child: CircularProgressIndicator());
          }
        },
      ),
    );
  }
}
