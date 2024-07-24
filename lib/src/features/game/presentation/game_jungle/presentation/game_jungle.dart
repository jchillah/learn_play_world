import 'package:flutter/material.dart';
import 'package:learn_play_world/src/config/colors/app_colors.dart';
import 'package:learn_play_world/src/data/video_path_provider/video_path_provider.dart';
import 'package:learn_play_world/src/features/game/presentation/game_end/presentation/game_end.dart';
import 'package:learn_play_world/src/features/utils/answer_button.dart';
import 'package:learn_play_world/src/features/utils/answer_mask.dart';
import 'package:learn_play_world/src/features/utils/menu_row.dart';
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
  late VideoPlayerController videoController;
  late String videoPath;
  late bool isAnswerCorrect;

  @override
  void initState() {
    super.initState();
    parrotButtonColor = AppColors.answerButtonColor;
    zebraButtonColor = AppColors.answerButtonColor;
    videoPath = VideoPathProvider.getVideoPath(widget.levelTheme, widget.level);
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
    videoController.dispose();
    super.dispose();
  }

  void handleAnimalSelection(String animal) {
    setState(() {
      if (animal == 'Zebra') {
        isAnswerCorrect = false;
        zebraButtonColor = AppColors.wrongAnswerButtonColor;
        parrotButtonColor = AppColors.answerButtonColor;
      } else if (animal == 'Parrot') {
        isAnswerCorrect = true;
        parrotButtonColor = AppColors.correctAnswerButtonColor;
        zebraButtonColor = AppColors.answerButtonColor;
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
          child: SingleChildScrollView(
            child: Column(
              children: <Widget>[
                const MenuRow(),
                const SizedBox(height: 50),
                AnswerButton(
                  levelTheme: 'Jungle',
                  isAnswerCorrect: true,
                  controller: videoController,
                  onPressed: () {
                    handleAnimalSelection('Parrot');
                    videoController.pause();
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => GameEnd(
                          levelTheme: widget.levelTheme,
                          level: widget.level,
                        ),
                      ),
                    );
                  },
                  imagePath: 'assets/images/animals/parrot.png',
                  buttonColor: parrotButtonColor,
                ),
                const SizedBox(height: 50),
                AnswerMask(
                  controller: videoController,
                  imageAsset: 'assets/images/animals/masks/parrot_mask.png',
                  width: 83,
                  height: 140,
                ),
                const SizedBox(height: 50),
                AnswerButton(
                  levelTheme: 'Jungle',
                  isAnswerCorrect: false,
                  controller: videoController,
                  onPressed: () {
                    handleAnimalSelection('Zebra');
                  },
                  imagePath: 'assets/images/animals/zebra.png',
                  buttonColor: zebraButtonColor,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
