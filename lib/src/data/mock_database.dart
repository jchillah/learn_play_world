import 'package:firebase_auth/firebase_auth.dart';
import 'package:learn_play_world/src/data/database_repository.dart';

class MockDatabase implements DatabaseRepository {
  int _score = 0;
  User? currentUser;

  @override
  Future<void> loginUser(User currentUser) async {
    this.currentUser = currentUser;
  }

  @override
  Future<User?> getUser() async {
    return currentUser;
  }

  @override
  Future<void> removedUser() async {
    currentUser = null;
  }

  @override
  Future<int> getScore() async {
    await Future.delayed(const Duration(seconds: 2));
    return _score;
  }

  @override
  Future<void> updateScore(int score) async {
    await Future.delayed(const Duration(seconds: 2));
    _score = score;
  }

  @override
  String getVideoPath(String levelTheme, int level) {
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
