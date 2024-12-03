import 'package:flutter/material.dart';

import '../../constants/colors.dart';
import '../../state/spaceship_notifier.dart';
import '../../utils/spaceship.dart';
import '../text/spaceship_name.dart';
import './gesture_detector_card.dart';

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
                            color: (AppColors.primary).withOpacity(0.9),
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
