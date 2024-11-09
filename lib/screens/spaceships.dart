import 'package:flutter/material.dart';
import '../components/card/gesture_detector_card.dart';
import '../components/navbar/navbar.dart';
import '../constants/spaceships.dart';

class SpaceshipsScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const CustomAppBar(
        title: 'Select a Spaceship',
      ),
      body: Column(
        children: [
          const SizedBox(
            height: 40,
          ),
          Expanded(
            child: GridView.builder(
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                childAspectRatio: 1.0,
              ),
              itemCount: spaceships.length,
              itemBuilder: (BuildContext context, int index) {
                final String spaceshipKey = spaceships.keys.elementAt(index);
                final Map<String, dynamic> spaceship =
                    spaceships[spaceshipKey]!;
                final String spaceshipName = spaceship['name'] as String;
                final String imagePath = spaceship['image'] as String;

                return Column(
                  children: <Widget>[
                    Text(spaceshipName),
                    Expanded(
                      child: GestureDetectorCard(
                        onTap: () async {
                          print('Spaceship $spaceshipName selected');
                        },
                        cardMargin: const EdgeInsets.only(
                          left: 40.0,
                          right: 40.0,
                          bottom: 80.0,
                        ),
                        child: Padding(
                          padding: const EdgeInsets.all(5.0),
                          child: Column(
                            children: <Widget>[
                              SizedBox(
                                height: 40,
                                width: 50,
                                child: Image.asset(imagePath),
                              ),
                              const Align(
                                child: Text('unlocks at level: '),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ],
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
