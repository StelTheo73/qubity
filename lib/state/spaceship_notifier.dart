import 'package:flutter/material.dart' show ChangeNotifier;

import '../constants/spaceships.dart';

class SpaceshipNotifier extends ChangeNotifier {
  String _selectedSpaceshipId = defaultSpaceshipId;

  String get selectedSpaceshipId => _selectedSpaceshipId;

  void setSelectedSpaceshipId(String spaceshipId) {
    _selectedSpaceshipId = spaceshipId;
    notifyListeners();
  }

  void resetState() {
    _selectedSpaceshipId = defaultSpaceshipId;
    notifyListeners();
  }
}

final SpaceshipNotifier spaceshipNotifier = SpaceshipNotifier();
