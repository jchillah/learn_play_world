import 'package:flutter/material.dart';
import 'package:learn_play_world/src/config/colors/app_colors.dart';
import 'package:learn_play_world/src/data/mock_database.dart';
import 'package:learn_play_world/src/features/game/presentation/game_Farm/presentation/menu_row.dart';
import 'package:learn_play_world/src/features/game/presentation/game_end/presentation/game_end.dart';
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
      if (animal == 'Zebra') {
        isAnswerCorrect = false;
        zebraButtonColor = AppColors.wrongAnswerButtonColor;
        parrotButtonColor = AppColors.answerButtonColor;
      } else if (animal == 'Parrot') {
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
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          child: Column(
            children: <Widget>[
              const MenuRow(),
              const SizedBox(
                height: 50,
              ),
              ElevatedButton(
                onPressed: () {
                  levelTheme = 'Farm';
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
                        arguments: ModalRoute.of(context)!.settings.arguments,
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
                        'assets/images/animals/parrot.png',
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
                      'assets/images/animals/masks/parrot_mask.png',
                      width: 100,
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
                  levelTheme = 'Jungle';
                  setState(
                    () {
                      handleAnimalSelection('Pig');
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
      ),
    );
  }
}
