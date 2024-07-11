import 'package:firebase_auth/firebase_auth.dart';

abstract class DatabaseRepository {
  Future<void> loginUser(User currentUser);
  Future<User?> getUser();
  Future<void> removedUser();
  Future<int> getScore();
  Future<void> updateScore(int score);
  String getVideoPath(String levelTheme, int level);
}
