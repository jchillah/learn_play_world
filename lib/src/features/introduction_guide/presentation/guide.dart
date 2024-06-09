import 'package:flutter/material.dart';
import 'package:learn_play_world/src/config/colors/app_colors.dart';
import 'package:learn_play_world/src/features/overview/presentation/overview.dart';

class Guide extends StatelessWidget {
  const Guide({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.backgroundColor,
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16),
        child: SingleChildScrollView(
          child: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const SizedBox(
                  height: 70,
                ),
                Image.asset(
                  'assets/images/learn_play_world.png',
                  width: 361,
                  height: 117,
                ),
                const SizedBox(height: 50),
                Image.asset(
                  'assets/images/logo_guide_text.png',
                  width: 362,
                  height: 366,
                ),
                const SizedBox(height: 50),
                GestureDetector(
                  onTap: () {
                    Navigator.push(
                      context,
                      PageRouteBuilder(
                        transitionDuration: const Duration(milliseconds: 300),
                        transitionsBuilder:
                            (context, animation, secondaryAnimation, child) {
                          return SlideTransition(
                            position: Tween(
                                    begin: const Offset(0.0, 1.0),
                                    end: Offset.zero)
                                .animate(animation),
                            child: child,
                          );
                        },
                        pageBuilder: (context, animation, secondaryAnimation) {
                          return const Overview();
                        },
                      ),
                    );
                  },
                  child: Image.asset(
                    'assets/images/buttons/start.png',
                    width: 300,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
