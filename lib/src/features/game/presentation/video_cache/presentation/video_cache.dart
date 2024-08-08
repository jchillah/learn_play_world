import 'package:video_player/video_player.dart';

class VideoCache {
  static final Map<String, VideoPlayerController> _cache = {};

  static VideoPlayerController getVideoController(String videoPath) {
    if (_cache.containsKey(videoPath)) {
      return _cache[videoPath]!;
    } else {
      final controller = VideoPlayerController.asset(
        videoPath,
        videoPlayerOptions: VideoPlayerOptions(allowBackgroundPlayback: true),
      );
      _cache[videoPath] = controller;
      return controller;
    }
  }

  static void disposeController(String videoPath) {
    if (_cache.containsKey(videoPath)) {
      _cache[videoPath]?.dispose();
      _cache.remove(videoPath);
    }
  }

  static void disposeAll() {
    for (var controller in _cache.values) {
      controller.dispose();
    }
    _cache.clear();
  }
}
