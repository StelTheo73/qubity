import 'package:shared_preferences/shared_preferences.dart';

import '../constants/spaceships.dart';

enum DeviceStoreKeys {
  unlockedLevel('unlockedLevel'),
  spaceshipId('spaceship');

  const DeviceStoreKeys(this.key);

  final String key;
}

class DeviceStore {
  static final SharedPreferencesAsync prefs = SharedPreferencesAsync();

  static Future<void> init() async {
    await _setupDeviceStore();
  }

  static Future<void> _setupDeviceStore() async {
    final int level =
        await prefs.getInt(DeviceStoreKeys.unlockedLevel.key) ?? -1;
    if (level == -1) {
      await prefs.setInt(DeviceStoreKeys.unlockedLevel.key, 1);
    }

    final String spaceship =
        await prefs.getString(DeviceStoreKeys.spaceshipId.key) ?? '';
    if (spaceship.isEmpty) {
      await prefs.setString(
          DeviceStoreKeys.spaceshipId.key, defaultSpaceshipId);
    }
  }
}
