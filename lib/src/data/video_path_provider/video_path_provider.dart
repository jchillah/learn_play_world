class VideoPathProvider {
  static String getVideoPath(String levelTheme, int level) {
    switch (levelTheme) {
      case 'Farm':
        return _getFarmVideoPath(level);
      case 'Jungle':
        return _getJungleVideoPath(level);
      case 'Ocean':
        return _getOceanVideoPath(level);
      default:
        return 'no level selected';
    }
  }

  static String _getFarmVideoPath(int level) {
    switch (level) {
      case 1:
        return 'assets/videos/chicken_video.mp4';
      default:
        return 'assets/videos/chicken_video.mp4';
    }
  }

  static String _getJungleVideoPath(int level) {
    switch (level) {
      case 1:
        return 'assets/videos/parrot_video.mp4';
      default:
        return 'assets/videos/parrot_video.mp4';
    }
  }

  static String _getOceanVideoPath(int level) {
    switch (level) {
      case 1:
        return 'assets/videos/whale_video.mp4';
      default:
        return 'assets/videos/whale_video.mp4';
    }
  }
}
