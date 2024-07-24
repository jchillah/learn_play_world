import 'package:flutter/material.dart';
import 'package:learn_play_world/src/config/colors/app_colors.dart';
import 'package:learn_play_world/src/data/video_path_provider/video_path_provider.dart';
import 'package:learn_play_world/src/features/game/presentation/game_end/presentation/game_end.dart';
import 'package:learn_play_world/src/features/utils/answer_button.dart';
import 'package:learn_play_world/src/features/utils/answer_mask.dart';
import 'package:learn_play_world/src/features/utils/menu_row.dart';
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
  late VideoPlayerController videoController;
  late String videoPath;
  late bool isAnswerCorrect;

  @override
  void initState() {
    super.initState();
    whaleButtonColor = AppColors.answerButtonColor;
    cancerButtonColor = AppColors.answerButtonColor;
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
      if (animal == 'Cancer') {
        isAnswerCorrect = false;
        cancerButtonColor = AppColors.wrongAnswerButtonColor;
        whaleButtonColor = AppColors.answerButtonColor;
      } else if (animal == 'Whale') {
        isAnswerCorrect = true;
        whaleButtonColor = AppColors.answerButtonColor;
        cancerButtonColor = AppColors.answerButtonColor;
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
                  levelTheme: 'Ocean',
                  isAnswerCorrect: false,
                  controller: videoController,
                  onPressed: () {
                    handleAnimalSelection('Cancer');
                  },
                  imagePath: 'assets/images/animals/cancer.png',
                  buttonColor: cancerButtonColor,
                ),
                const SizedBox(height: 50),
                AnswerMask(
                  controller: videoController,
                  imageAsset: 'assets/images/animals/masks/whale_mask.png',
                  width: 210,
                  height: 120,
                ),
                const SizedBox(height: 50),
                AnswerButton(
                  levelTheme: 'Ocean',
                  isAnswerCorrect: true,
                  controller: videoController,
                  onPressed: () {
                    handleAnimalSelection('Whale');
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
                  imagePath: 'assets/images/animals/whale.png',
                  buttonColor: whaleButtonColor,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
