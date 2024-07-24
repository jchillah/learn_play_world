import 'package:flutter/material.dart';
import 'package:learn_play_world/src/config/colors/app_colors.dart';
import 'package:learn_play_world/src/data/mock_database.dart';
import 'package:learn_play_world/src/features/overview/presentation/overview.dart';
import 'package:video_player/video_player.dart';

class GameEndVideo extends StatefulWidget {
  final String levelTheme;
  final int level;

  const GameEndVideo({
    super.key,
    required this.levelTheme,
    required this.level,
  });

  @override
  GameEndVideoState createState() => GameEndVideoState();
}

class GameEndVideoState extends State<GameEndVideo> {
  late VideoPlayerController _controller;
  late String _videoPath;
  late String levelTheme = widget.levelTheme;
  bool levelCompleted = false;

  @override
  void initState() {
    super.initState();
    _videoPath = MockDatabase().getVideoPath(widget.levelTheme, widget.level);
    _controller = VideoPlayerController.asset(
      _videoPath,
      videoPlayerOptions: VideoPlayerOptions(allowBackgroundPlayback: true),
    )..initialize().then((_) {
        setState(() {
          _controller.play();
          _controller.setLooping(false);
        });
      });

    levelCompleted = checkLevelCompletion(widget.levelTheme, widget.level);
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  bool checkLevelCompletion(String levelTheme, int level) {
    if (levelTheme == 'Farm' && level == 1 && levelCompleted) {
      return true;
    }

    return false;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.backgroundColor,
      body: SingleChildScrollView(
        child: Center(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const SizedBox(height: 100),
                Column(
                  children: [
                    const SizedBox(height: 20),
                    Padding(
                      padding: const EdgeInsets.all(16.0),
                      child: Image.asset(
                        'assets/images/great_job.png',
                        fit: BoxFit.contain,
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 20),
                GestureDetector(
                  onTap: () {
                    setState(() {
                      _controller.pause();
                    });
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) {
                        return const Overview();
                      }),
                    );
                  },
                  child:
                      Image.asset("assets/images/buttons/next_game_button.png"),
                ),
                const SizedBox(height: 40),
                if (levelCompleted)
                  _controller.value.isInitialized
                      ? Padding(
                          padding: const EdgeInsets.only(left: 16.0, right: 16),
                          child: AspectRatio(
                            aspectRatio: _controller.value.aspectRatio,
                            child: VideoPlayer(_controller),
                          ),
                        )
                      : const CircularProgressIndicator()
                else
                  Container(
                    child: _controller.value.isInitialized
                        ? Padding(
                            padding:
                                const EdgeInsets.only(left: 16.0, right: 16),
                            child: AspectRatio(
                              aspectRatio: _controller.value.aspectRatio,
                              child: VideoPlayer(_controller),
                            ),
                          )
                        : const CircularProgressIndicator(),
                  ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
