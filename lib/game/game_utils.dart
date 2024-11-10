class GameUtils {
  static String extractImagePath(String imagePath) {
    return imagePath.startsWith('assets/images')
        ? imagePath.replaceFirst('assets/images/', '')
        : imagePath;
  }
}
