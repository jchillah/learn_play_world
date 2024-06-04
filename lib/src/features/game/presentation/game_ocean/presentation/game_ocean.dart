import 'package:flutter/material.dart';
import 'package:learn_play_world/src/config/colors/app_colors.dart';
import 'package:learn_play_world/src/data/video_path_provider/video_path_provider.dart';
import 'package:learn_play_world/src/features/game/presentation/game_end/presentation/game_end.dart';
import 'package:learn_play_world/src/features/introduction_guide/presentation/introduction.dart';
import 'package:learn_play_world/src/features/setting/presentation/unlock_setting_task.dart';
import 'package:video_player/video_player.dart';

class GameOcean extends StatefulWidget {
  final String levelTheme;
  final int level;

  const GameOcean({
    super.key,
    required this.levelTheme,
    required this.level,
  });

  @override
  GameOceanState createState() => GameOceanState();
}

class GameOceanState extends State<GameOcean> {
  late Color whaleButtonColor;
  late Color cancerButtonColor;
  late VideoPlayerController _controller;
  late String _videoPath;
  late bool isAnswerCorrect = false;
  late String levelTheme = widget.levelTheme;

  @override
  void initState() {
    super.initState();
    whaleButtonColor = AppColors.answerButtonColor;
    cancerButtonColor = AppColors.answerButtonColor;
    _videoPath =
        VideoPathProvider.getVideoPath(widget.levelTheme, widget.level);
    _controller = VideoPlayerController.asset(
      _videoPath,
      videoPlayerOptions: VideoPlayerOptions(allowBackgroundPlayback: true),
    )..initialize().then((_) {
        setState(() {
          _controller.play();
          _controller.setLooping(false);
        });
      });
  }

  @override
  void dispose() {
    super.dispose();
    _controller.dispose();
  }

  void handleAnimalSelection(String animal) {
    setState(() {
      if (animal == 'cancer') {
        isAnswerCorrect = false;
        cancerButtonColor = AppColors.wrongAnswerButtonColor;
        whaleButtonColor = AppColors.answerButtonColor;
      } else if (animal == 'whale') {
        isAnswerCorrect = true;
        whaleButtonColor = AppColors.answerButtonColor;
        cancerButtonColor = AppColors.answerButtonColor;
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.backgroundColor,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          child: Column(
            children: <Widget>[
              Row(
                children: <Widget>[
                  GestureDetector(
                    onTap: () {
                      showModalBottomSheet(
                        context: context,
                        builder: (context) {
                          return const Introduction();
                        },
                      );
                    },
                    child: Image.asset(
                      'assets/images/buttons/questionmark4.png',
                      width: 80,
                      height: 120,
                      fit: BoxFit.contain,
                    ),
                  ),
                  const Spacer(),
                  GestureDetector(
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => const UnlockSettingTask()),
                      );
                    },
                    child: Image.asset(
                      'assets/images/buttons/settings_button.png',
                      width: 80,
                      height: 120,
                      fit: BoxFit.contain,
                    ),
                  ),
                ],
              ),
              const SizedBox(
                height: 50,
              ),
              ElevatedButton(
                onPressed: () {
                  levelTheme = 'Farm';
                  setState(
                    () {
                      handleAnimalSelection('cancer');
                    },
                  );
                },
                style: ElevatedButton.styleFrom(
                  padding: EdgeInsets.zero,
                  backgroundColor: cancerButtonColor,
                  fixedSize: const Size(247, 149),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                  shadowColor:
                      const Color.fromARGB(255, 10, 10, 10).withOpacity(0.4),
                  elevation: 4,
                ),
                child: Stack(
                  alignment: Alignment.center,
                  children: [
                    ClipRRect(
                      borderRadius: BorderRadius.circular(12),
                      child: Image.asset(
                        'assets/images/animals/cancer.png',
                        fit: BoxFit.contain,
                      ),
                    ),
                  ],
                ),
              ),
              GestureDetector(
                onTap: () {
                  setState(() {
                    if (_controller.value.isPlaying) {
                      _controller.pause();
                    } else {
                      _controller.play();
                    }
                  });
                },
                child: Stack(
                  alignment: Alignment.center,
                  children: [
                    Image.asset(
                      'assets/images/animals/masks/whale_mask.png',
                      width: 150,
                      height: 160,
                      fit: BoxFit.contain,
                    ),
                    if (_controller.value.isInitialized)
                      SizedBox(
                        height: 0,
                        width: 0,
                        child: VideoPlayer(_controller),
                      ),
                  ],
                ),
              ),
              ElevatedButton(
                onPressed: () {
                  levelTheme = 'Ocean';
                  setState(() {
                    isAnswerCorrect = true;
                    whaleButtonColor = AppColors.answerButtonColor;
                    cancerButtonColor = AppColors.answerButtonColor;
                    _controller.pause();
                  });

                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => GameEnd(
                        levelTheme: levelTheme,
                        level: 1,
                      ),
                      settings: RouteSettings(
                        arguments: ModalRoute.of(context)!.settings.arguments,
                      ),
                    ),
                  );
                },
                style: ElevatedButton.styleFrom(
                  padding: EdgeInsets.zero,
                  backgroundColor: whaleButtonColor,
                  fixedSize: const Size(247, 149),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                  shadowColor:
                      const Color.fromARGB(255, 10, 10, 10).withOpacity(0.4),
                  elevation: 4,
                ),
                child: Stack(
                  alignment: Alignment.center,
                  children: [
                    ClipRRect(
                      borderRadius: BorderRadius.circular(12),
                      child: Image.asset(
                        'assets/images/animals/whale.png',
                        fit: BoxFit.contain,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
