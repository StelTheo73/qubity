import '../constants/spaceships.dart';
import 'device_store.dart';

class SpaceshipLoader {
  static Future<Map<String, dynamic>> getSelectedSpaceship() async {
    final String spaceshipId = await getSelectedSpaceshipId();
    return spaceships[spaceshipId]!;
  }

  static Future<String> getSelectedSpaceshipId() async {
    return await DeviceStore.prefs.getString(DeviceStoreKeys.spaceshipId.key) ??
        defaultSpaceshipId;
  }

  static Future<bool> hasUnlockedSpaceship(int levelId) async {
    final int lastUnlockedLevel = await DeviceStore.getUnlockedLevel();
    if (levelId < lastUnlockedLevel) {
      return false;
    }

    for (final Map<String, dynamic> spaceship in spaceships.values) {
      final int spaceshipUnlockLevel = spaceship['level']! as int;
      if (lastUnlockedLevel <= spaceshipUnlockLevel &&
          levelId >= spaceshipUnlockLevel) {
        return true;
      }
    }

    return false;
  }

  static Future<void> setSelectedSpaceship(String spaceshipId) async {
    await DeviceStore.prefs
        .setString(DeviceStoreKeys.spaceshipId.key, spaceshipId);
  }
}
