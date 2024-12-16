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

  // Public Methods
  // --------------

  static Future<void> init() async {
    await _setupDeviceStore();
  }

  static Future<int> getUnlockedLevel() async {
    return (await prefs.getInt(DeviceStoreKeys.unlockedLevel.key)) ?? 1;
  }

  static Future<void> setUnlockedLevel(int level) async {
    await prefs.setInt(DeviceStoreKeys.unlockedLevel.key, level);
  }

  static Future<void> resetDeviceStore() async {
    await prefs.setInt(DeviceStoreKeys.unlockedLevel.key, 1);
    await prefs.setString(DeviceStoreKeys.spaceshipId.key, defaultSpaceshipId);
  }

  // Private Methods
  // ---------------

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
