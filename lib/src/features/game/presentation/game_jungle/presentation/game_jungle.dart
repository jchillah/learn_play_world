import 'package:flutter/material.dart';
import 'package:learn_play_world/src/config/colors/app_colors.dart';
import 'package:learn_play_world/src/config/video_path_provider/video_path_provider.dart';
import 'package:learn_play_world/src/features/game/presentation/game_end/presentation/game_end.dart';
import 'package:learn_play_world/src/features/introduction_guide/presentation/introduction.dart';
import 'package:video_player/video_player.dart';

class GameJungle extends StatefulWidget {
  final String levelTheme;
  final int level;

  const GameJungle({
    super.key,
    required this.levelTheme,
    required this.level,
  });

  @override
  GameJungleState createState() => GameJungleState();
}

class GameJungleState extends State<GameJungle> {
  late Color parrotButtonColor;
  late Color zebraButtonColor;
  late VideoPlayerController _controller;
  late String _videoPath;
  late bool isAnswerCorrect = false;
  late String levelTheme = widget.levelTheme;

  @override
  void initState() {
    super.initState();
    parrotButtonColor = AppColors.answerButtonColor;
    zebraButtonColor = AppColors.answerButtonColor;
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
    _controller.dispose();
    super.dispose();
  }

  void handleAnimalSelection(String animal) {
    setState(() {
      if (animal == 'zebra') {
        isAnswerCorrect = false;
        zebraButtonColor = AppColors.wrongAnswerButtonColor;
        parrotButtonColor = AppColors.answerButtonColor;
      } else if (animal == 'parrot') {
        isAnswerCorrect = true;
        parrotButtonColor = AppColors.answerButtonColor;
        zebraButtonColor = AppColors.answerButtonColor;
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.backgroundColor,
      body: SafeArea(
        child: Stack(
          children: [
            Positioned(
              left: 16,
              top: 61,
              child: GestureDetector(
                onTap: () {
                  Navigator.pop(context);
                },
                child: Image.asset(
                  'assets/images/buttons/back_button.png',
                  width: 50,
                  height: 40,
                  fit: BoxFit.cover,
                ),
              ),
            ),
            Positioned(
              right: 16,
              top: 51,
              child: GestureDetector(
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
                  width: 50,
                  height: 40,
                  fit: BoxFit.cover,
                ),
              ),
            ),
            Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  const SizedBox(height: 40),
                  ElevatedButton(
                    onPressed: () {
                      levelTheme = 'Jungle';
                      setState(() {
                        isAnswerCorrect = true;
                        parrotButtonColor = AppColors.answerButtonColor;
                        zebraButtonColor = AppColors.answerButtonColor;
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
                            arguments:
                                ModalRoute.of(context)!.settings.arguments,
                          ),
                        ),
                      );
                    },
                    style: ElevatedButton.styleFrom(
                      padding: EdgeInsets.zero,
                      backgroundColor: parrotButtonColor,
                      fixedSize: const Size(247, 149),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                      shadowColor: const Color.fromARGB(255, 10, 10, 10)
                          .withOpacity(0.4),
                      elevation: 4,
                    ),
                    child: Stack(
                      alignment: Alignment.center,
                      children: [
                        ClipRRect(
                          borderRadius: BorderRadius.circular(12),
                          child: Image.asset(
                            'assets/images/animals/parrot.png',
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
                          'assets/images/animals/masks/parrot_mask.png',
                          width: 83,
                          height: 87,
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
                      levelTheme = 'Jungle';
                      setState(
                        () {
                          handleAnimalSelection('zebra');
                        },
                      );
                    },
                    style: ElevatedButton.styleFrom(
                      padding: EdgeInsets.zero,
                      backgroundColor: zebraButtonColor,
                      fixedSize: const Size(247, 149),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                      shadowColor: const Color.fromARGB(255, 10, 10, 10)
                          .withOpacity(0.4),
                      elevation: 4,
                    ),
                    child: Stack(
                      alignment: Alignment.center,
                      children: [
                        ClipRRect(
                          borderRadius: BorderRadius.circular(12),
                          child: Image.asset(
                            'assets/images/animals/zebra.png',
                            fit: BoxFit.contain,
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
