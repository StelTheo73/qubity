import 'package:flutter/material.dart';
import '../components/card/gesture_detector_card.dart';
import '../components/navbar/navbar.dart';
import '../components/text/spaceship_name.dart';
import '../constants/spaceships.dart';
import '../utils/level.dart';
import '../utils/spaceship.dart';

class SpaceshipNotifier extends ChangeNotifier {
  String _selectedSpaceshipId = defaultSpaceshipId;

  String get selectedSpaceshipId => _selectedSpaceshipId;

  void setSelectedSpaceshipId(String spaceshipId) {
    _selectedSpaceshipId = spaceshipId;
    notifyListeners();
  }
}

class UnlockedSpaceShip extends StatelessWidget {
  const UnlockedSpaceShip({
    super.key,
    required this.spaceshipName,
    required this.spaceShipId,
    required this.imagePath,
    required this.spaceshipNotifier,
  });

  final String spaceshipName;
  final String spaceShipId;
  final String imagePath;
  final SpaceshipNotifier spaceshipNotifier;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        SpaceshipNameText(name: spaceshipName),
        Expanded(
          child: ListenableBuilder(
              listenable: spaceshipNotifier,
              builder: (BuildContext context, Widget? child) {
                return GestureDetectorCard(
                  onTap: () async {
                    spaceshipNotifier.setSelectedSpaceshipId(spaceShipId);
                    await SpaceshipLoader.setSelectedSpaceship(spaceShipId);
                  },
                  cardMargin: const EdgeInsets.only(
                    left: 40.0,
                    right: 40.0,
                    bottom: 40.0,
                  ),
                  opacity: spaceShipId != spaceshipNotifier.selectedSpaceshipId,
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
                        if (spaceShipId ==
                            spaceshipNotifier.selectedSpaceshipId)
                          Icon(
                            Icons.check_circle,
                            size: 40.0,
                            color: Colors.purple.withOpacity(0.9),
                          ),
                      ],
                    ),
                  ),
                );
              }),
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
            opacity: true,
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
    return Scaffold(
      appBar: const CustomAppBar(
        title: 'Select a Spaceship',
      ),
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
