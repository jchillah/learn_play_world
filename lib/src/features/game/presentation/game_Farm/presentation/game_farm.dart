import 'package:flutter/material.dart';
import 'package:learn_play_world/src/config/colors/app_colors.dart';
import 'package:learn_play_world/src/data/mock_database.dart';
import 'package:learn_play_world/src/features/game/presentation/game_end/presentation/game_end.dart';
import 'package:learn_play_world/src/features/utils/answer_button.dart';
import 'package:learn_play_world/src/features/utils/answer_mask.dart';
import 'package:learn_play_world/src/features/utils/menu_row.dart';
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
  late VideoPlayerController videoController;
  late String videoPath;
  late bool isAnswerCorrect;
  late String levelTheme = widget.levelTheme;

  @override
  void initState() {
    super.initState();
    chickenButtonColor = AppColors.answerButtonColor;
    pigButtonColor = AppColors.answerButtonColor;
    videoPath = MockDatabase().getVideoPath(widget.levelTheme, widget.level);
    videoController = VideoPlayerController.asset(
      videoPath,
      videoPlayerOptions: VideoPlayerOptions(allowBackgroundPlayback: true),
    )..initialize().then((_) {
        setState(() {
          videoController.play();
          videoController.setLooping(false);
        });
      });
  }

  @override
  void dispose() {
    super.dispose();
    videoController.dispose();
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
    return SafeArea(
      child: Scaffold(
        backgroundColor: AppColors.backgroundColor,
        body: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          child: Column(
            children: <Widget>[
              const MenuRow(),
              const SizedBox(
                height: 50,
              ),
              AnswerButton(
                  levelTheme: "Farm",
                  isAnswerCorrect: true,
                  controller: videoController,
                  onPressed: () {
                    levelTheme = 'Farm';
                    setState(() {
                      isAnswerCorrect = true;
                      handleAnimalSelection('Chicken');
                      videoController.pause();
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
                  imagePath: 'assets/images/animals/chicken.png',
                  buttonColor: chickenButtonColor),
              const SizedBox(
                height: 50,
              ),
              AnswerMask(
                controller: videoController,
                imageAsset: 'assets/images/animals/masks/chicken_mask.png',
                width: 140,
                height: 150,
              ),
              const SizedBox(
                height: 50,
              ),
              AnswerButton(
                  levelTheme: 'Farm',
                  isAnswerCorrect: false,
                  controller: videoController,
                  onPressed: () {
                    levelTheme = 'Farm';
                    setState(
                      () {
                        handleAnimalSelection('Pig');
                      },
                    );
                  },
                  imagePath: 'assets/images/animals/pig.png',
                  buttonColor: pigButtonColor),
            ],
          ),
        ),
      ),
    );
  }
}
