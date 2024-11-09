import 'package:shared_preferences/shared_preferences.dart';

import '../constants/spaceships.dart';

enum DeviceStoreKeys {
  level('level'),
  spaceship('spaceship');

  const DeviceStoreKeys(this.key);

  final String key;
}

class DeviceStore {
  static late final SharedPreferences prefs;

  static Future<void> init() async {
    prefs = await SharedPreferences.getInstance();
    await _setupDeviceStore();
  }

  static Future<void> _setupDeviceStore() async {
    final int level = prefs.getInt(DeviceStoreKeys.level.key) ?? -1;
    if (level == -1) {
      await prefs.setInt(DeviceStoreKeys.level.key, 1);
    }

    final String spaceship =
        prefs.getString(DeviceStoreKeys.spaceship.key) ?? '';
    if (spaceship.isEmpty) {
      await prefs.setString(
          DeviceStoreKeys.spaceship.key, spaceships['001']!['image'] as String);
    }
  }
}
