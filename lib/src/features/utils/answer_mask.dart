import 'package:flutter/material.dart';
import 'package:video_player/video_player.dart';

class AnswerMask extends StatelessWidget {
  final VideoPlayerController controller;
  final String imageAsset;
  final double width;
  final double height;

  const AnswerMask({super.key, required this.controller, required this.imageAsset, required this.width, required this.height});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        if (controller.value.isPlaying) {
          controller.pause();
        } else {
          controller.play();
        }
      },
      child: Stack(
        alignment: Alignment.center,
        children: [
          Image.asset(
            imageAsset,
            width: width,
            height: height,
            fit: BoxFit.cover,
          ),
          if (controller.value.isInitialized)
            SizedBox(
              height: 0,
              width: 0,
              child: VideoPlayer(controller),
            ),
        ],
      ),
    );
  }
}
