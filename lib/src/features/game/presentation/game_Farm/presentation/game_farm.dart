import 'package:flutter/material.dart';
import 'package:learn_play_world/src/config/colors/app_colors.dart';
import 'package:learn_play_world/src/data/mock_database.dart';
import 'package:learn_play_world/src/features/game/presentation/game_end/presentation/game_end.dart';
import 'package:learn_play_world/src/features/introduction_guide/presentation/introduction.dart';
import 'package:learn_play_world/src/features/setting/presentation/unlock_setting_task.dart';
import 'package:video_player/video_player.dart';

class GameFarm extends StatefulWidget {
  final String levelTheme;
  final int level;

  const GameFarm({
    super.key,
    required this.levelTheme,
    required this.level,
  });

  @override
  GameFarmState createState() => GameFarmState();
}

class GameFarmState extends State<GameFarm> {
  late Color chickenButtonColor;
  late Color pigButtonColor;
  late VideoPlayerController _controller;
  late String _videoPath;
  late bool isAnswerCorrect = false;
  late String levelTheme = widget.levelTheme;

  @override
  void initState() {
    super.initState();
    chickenButtonColor = AppColors.answerButtonColor;
    pigButtonColor = AppColors.answerButtonColor;
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
  }

  @override
  void dispose() {
    super.dispose();
    _controller.dispose();
  }

  void handleAnimalSelection(String animal) {
    setState(() {
      if (animal == 'Pig') {
        isAnswerCorrect = false;
        pigButtonColor = AppColors.wrongAnswerButtonColor;
        chickenButtonColor = AppColors.answerButtonColor;
      } else if (animal == 'Chicken') {
        isAnswerCorrect = true;
        chickenButtonColor = AppColors.answerButtonColor;
        pigButtonColor = AppColors.answerButtonColor;
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
                      'assets/images/buttons/questionmark.png',
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
                  setState(() {
                    isAnswerCorrect = true;
                    chickenButtonColor = AppColors.answerButtonColor;
                    pigButtonColor = AppColors.answerButtonColor;
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
                  backgroundColor: chickenButtonColor,
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
                        'assets/images/animals/chicken.png',
                        fit: BoxFit.contain,
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(
                height: 50,
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
                      'assets/images/animals/masks/chicken_mask.png',
                      width: 140,
                      height: 150,
                      fit: BoxFit.cover,
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
              const SizedBox(
                height: 50,
              ),
              ElevatedButton(
                onPressed: () {
                  levelTheme = 'Farm';
                  setState(
                    () {
                      handleAnimalSelection('Pig');
                    },
                  );
                },
                style: ElevatedButton.styleFrom(
                  padding: EdgeInsets.zero,
                  backgroundColor: pigButtonColor,
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
                        'assets/images/animals/pig.png',
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
