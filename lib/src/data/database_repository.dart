abstract class DatabaseRepository {
  Future<int> getScore();
  Future<void> updateScore(int score);
  String getVideoPath(String levelTheme, int level);
}
