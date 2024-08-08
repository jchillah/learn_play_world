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

  @override
  void initState() {
    super.initState();
    _videoPath = MockDatabase().getVideoPath(widget.levelTheme, widget.level);
    _controller = VideoPlayerController.asset(
      _videoPath,
      videoPlayerOptions: VideoPlayerOptions(allowBackgroundPlayback: true),
    )..initialize().then((_) {
        if (mounted) {
          setState(() {
            _controller.play();
            _controller.setLooping(false);
          });
        }
      });
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
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
              Padding(
                padding: const EdgeInsets.all(16.0),
                child: Image.asset('assets/images/great_job.png', fit: BoxFit.contain),
              ),
              const SizedBox(height: 20),
              GestureDetector(
                onTap: () {
                  _controller.pause();
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => const Overview()),
                  );
                },
                child: Image.asset("assets/images/buttons/next_game_button.png"),
              ),
              const SizedBox(height: 40),
              _controller.value.isInitialized
                  ? Padding(
                      padding: const EdgeInsets.only(left: 16.0, right: 16),
                      child: AspectRatio(
                        aspectRatio: _controller.value.aspectRatio,
                        child: VideoPlayer(_controller),
                      ),
                    )
                  : const CircularProgressIndicator(),
            ],
          ),
        ),
      ),
    ),
  );
}
}