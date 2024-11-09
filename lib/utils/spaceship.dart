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

  static Future<void> setSelectedSpaceship(String spaceshipId) async {
    await DeviceStore.prefs
        .setString(DeviceStoreKeys.spaceshipId.key, spaceshipId);
  }
}
