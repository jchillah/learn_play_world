import 'dart:async';

import 'package:flutter/material.dart';
import 'package:learn_play_world/src/config/colors/app_colors.dart';
import 'package:learn_play_world/src/features/game/presentation/game_end_video/presentation/game_end_video.dart';

class GameEnd extends StatefulWidget {
  const GameEnd({
    super.key,
    required this.levelTheme,
    required this.level,
  });

  final String levelTheme;
  final int level;

  @override
  State<GameEnd> createState() => GameEndState();
}

class GameEndState extends State<GameEnd> {
  Timer? _timer;

  @override
  void initState() {
    super.initState();
    _timer = Timer(const Duration(seconds: 3), () {
      if (mounted) {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => GameEndVideo(
                levelTheme: widget.levelTheme, level: widget.level),
            settings: RouteSettings(
              arguments: ModalRoute.of(context)!.settings.arguments,
            ),
          ),
        );
      }
    });
  }

  @override
  void dispose() {
    _timer?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.backgroundColor,
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16.0),
            child: Center(
              child: Column(
                children: [
                  Image.asset(
                    'assets/images/great.png',
                    fit: BoxFit.contain,
                  ),
                  const SizedBox(height: 20),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
