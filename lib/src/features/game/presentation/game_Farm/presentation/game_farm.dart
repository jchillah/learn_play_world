import 'package:flutter/material.dart';
import 'package:learn_play_world/src/config/colors/app_colors.dart';
import 'package:learn_play_world/src/config/video_path_provider/video_path_provider.dart';
import 'package:learn_play_world/src/features/game/presentation/game_end/presentation/game_end.dart';
import 'package:learn_play_world/src/features/introduction_guide/presentation/introduction.dart';
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

  // void changeButtonColorOnWrongAnswer(String animal) {
  //   setState(() {
  //     _showButtons = false;
  //     if (animal == 'assets/${widget.theme}/level${widget.level}_wrong.png') {
  //       isAnswerCorrect = false;
  //       wrongAnswer = AppColors.wrongAnswerButtonColor;
  //       correctAnswer = AppColors.answerButtonColor;
  //     } else if (animal ==
  //         'assets/${widget.theme}/level${widget.level}_correct.png') {
  //       isAnswerCorrect = true;
  //       correctAnswer = AppColors.answerButtonColor;
  //       wrongAnswer = AppColors.answerButtonColor;
  //       Future.delayed(const Duration(seconds: 5), () {
  //           Navigator.push(
  //             context,
  //             MaterialPageRoute(builder: (context) {
  //               return ResultScreen(theme: widget.theme, level: widget.level);
  //             }),
  //           );
  //           Provider.of<Score>(context, listen: false).addPoints(100);
  //         });
  //     }
  //   });
  // }

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
                            arguments:
                                ModalRoute.of(context)!.settings.arguments,
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
                            'assets/images/animals/chicken.png',
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
                          'assets/images/animals/masks/chicken_mask.png',
                          width: 83,
                          height: 87,
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
          ],
        ),
      ),
    );
  }
}
