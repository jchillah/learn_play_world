import 'package:flutter/material.dart';
import 'package:learn_play_world/src/config/colors/app_colors.dart';
import 'package:learn_play_world/src/data/video_path_provider/video_path_provider.dart';
import 'package:learn_play_world/src/features/game/presentation/game_end/presentation/game_end.dart';
import 'package:learn_play_world/src/features/game/presentation/video_cache/presentation/video_cache.dart';
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

  @override
  void initState() {
    super.initState();
    parrotButtonColor = AppColors.answerButtonColor;
    zebraButtonColor = AppColors.answerButtonColor;
    videoPath = VideoPathProvider.getVideoPath(widget.levelTheme, widget.level);

    // Hole den VideoPlayerController aus dem Cache und initialisiere ihn
    videoController = VideoCache.getVideoController(videoPath)
      ..initialize().then((_) {
        if (mounted) {
          setState(() {
            videoController.play();
            videoController.setLooping(false);
          });
        }
      }).catchError((error) {
        // Fehlerbehandlung für den Fall, dass das Initialisieren fehlschlägt
        debugPrint('Error initializing video controller: $error');
        // Optional: Fehlerbehandlung oder Fallback-Logik hier hinzufügen
      });
  }

  @override
  void dispose() {
    // VideoController freigeben, um Ressourcen zu sparen
    VideoCache.disposeController(videoPath);
    super.dispose();
  }

  void handleAnimalSelection(String animal) {
    if (animal == 'Zebra' &&
            zebraButtonColor != AppColors.wrongAnswerButtonColor ||
        animal == 'Parrot' &&
            parrotButtonColor != AppColors.correctAnswerButtonColor) {
      setState(() {
        zebraButtonColor = animal == 'Zebra'
            ? AppColors.wrongAnswerButtonColor
            : AppColors.answerButtonColor;
        parrotButtonColor = animal == 'Parrot'
            ? AppColors.correctAnswerButtonColor
            : AppColors.answerButtonColor;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.backgroundColor,
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16),
        child: SafeArea(
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
