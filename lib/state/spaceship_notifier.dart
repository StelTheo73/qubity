import 'package:flutter/material.dart';

import '../constants/spaceships.dart';

class SpaceshipNotifier extends ChangeNotifier {
  String _selectedSpaceshipId = defaultSpaceshipId;

  String get selectedSpaceshipId => _selectedSpaceshipId;

  void setSelectedSpaceshipId(String spaceshipId) {
    _selectedSpaceshipId = spaceshipId;
    notifyListeners();
  }
}
