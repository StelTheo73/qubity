import 'package:flutter/material.dart';
import '../components/card/gesture_detector_card.dart';
import '../components/navbar/navbar.dart';
import '../components/text/spaceship_name.dart';
import '../constants/spaceships.dart';
import '../utils/level.dart';
import '../utils/spaceship.dart';

class UnlockedSpaceShip extends StatelessWidget {
  UnlockedSpaceShip({
    super.key,
    required this.spaceshipName,
    required this.imagePath,
    this.isSelected = false,
  });

  final String spaceshipName;
  final String imagePath;
  bool isSelected = false;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        SpaceshipNameText(name: spaceshipName),
        Expanded(
          child: GestureDetectorCard(
            onTap: () async {
              print('Spaceship $spaceshipName selected');
            },
            cardMargin: const EdgeInsets.only(
              left: 40.0,
              right: 40.0,
              bottom: 40.0,
            ),
            child: Padding(
              padding: const EdgeInsets.all(5.0),
              child: Stack(
                alignment: Alignment.center,
                children: <Widget>[
                  SizedBox(
                    height: 60,
                    width: double.infinity,
                    child: Image.asset(imagePath),
                  ),
                  if (isSelected)
                    Icon(
                      Icons.check_circle,
                      size: 40.0,
                      color: Colors.green.withOpacity(0.9),
                    ),
                ],
              ),
            ),
          ),
        ),
      ],
    );
  }
}

class LockedSpaceship extends StatelessWidget {
  const LockedSpaceship({
    super.key,
    required this.spaceshipName,
    required this.imagePath,
  });

  final String spaceshipName;
  final String imagePath;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        SpaceshipNameText(name: spaceshipName),
        Expanded(
          child: GestureDetectorCard(
            disabled: true,
            cardMargin: const EdgeInsets.only(
              left: 40.0,
              right: 40.0,
              bottom: 40.0,
            ),
            child: Padding(
              padding: const EdgeInsets.all(5.0),
              child: Stack(
                alignment: Alignment.center,
                children: <Widget>[
                  SizedBox(
                    height: 60,
                    width: double.infinity,
                    child: Image.asset(imagePath),
                  ),
                  Icon(
                    Icons.lock,
                    size: 40.0,
                    color: Colors.grey.withOpacity(0.9),
                  ),
                ],
              ),
            ),
          ),
        ),
      ],
    );
  }
}

class SpaceshipsScreen extends StatefulWidget {
  const SpaceshipsScreen({super.key});

  @override
  _SpaceshipsScreenState createState() => _SpaceshipsScreenState();
}

class _SpaceshipsScreenState extends State<SpaceshipsScreen> {
  late Future<int> lastUnlockedLevelFuture;
  late Future<String> selectedSpaceshipIdFuture;

  @override
  void initState() {
    super.initState();
    setState(() {
      lastUnlockedLevelFuture = LevelLoader.getLastUnlockedLevel();
    });
    setState(() {
      selectedSpaceshipIdFuture = SpaceshipLoader.getSelectedSpaceshipId();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const CustomAppBar(
        title: 'Select a Spaceship',
      ),
      body: FutureBuilder<int>(
        future: lastUnlockedLevelFuture,
        builder: (BuildContext context, AsyncSnapshot<int> snapshot) {
          if (snapshot.hasData) {
            final int currentLevel = snapshot.data!;
            return Column(
              children: [
                const SizedBox(
                  height: 40,
                ),
                Expanded(
                  child: GridView.builder(
                    gridDelegate:
                        const SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 2,
                      childAspectRatio: 1.0,
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
                        imagePath: imagePath,
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
