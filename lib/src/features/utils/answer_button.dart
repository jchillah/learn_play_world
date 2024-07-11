import 'package:flutter/material.dart';
// ignore: unused_import
import 'package:learn_play_world/src/config/colors/app_colors.dart';
import 'package:video_player/video_player.dart';

class AnswerButton extends StatefulWidget {
  final String levelTheme;
  final bool isAnswerCorrect;
  final VoidCallback onPressed;
  final VideoPlayerController controller;
  final String imagePath;
  final Color buttonColor;

  const AnswerButton({
    super.key,
    required this.levelTheme,
    required this.isAnswerCorrect,
    required this.controller,
    required this.onPressed,
    required this.imagePath,
    required this.buttonColor,
  });

  @override
  State<AnswerButton> createState() => _AnswerButtonState();
}

class _AnswerButtonState extends State<AnswerButton> {
  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: widget.onPressed,
      style: ElevatedButton.styleFrom(
        padding: EdgeInsets.zero,
        backgroundColor: widget.buttonColor,
        fixedSize: const Size(247, 149),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12),
        ),
        shadowColor: const Color.fromARGB(255, 10, 10, 10).withOpacity(0.4),
        elevation: 4,
      ),
      child: Stack(
        alignment: Alignment.center,
        children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(12),
            child: Image.asset(
              widget.imagePath,
              fit: BoxFit.contain,
            ),
          ),
        ],
      ),
    );
  }
}
