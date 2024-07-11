import 'package:flutter/material.dart';
import 'package:learn_play_world/src/config/colors/app_colors.dart';
import 'package:learn_play_world/src/features/introduction_guide/presentation/guide.dart';

class Welcome extends StatelessWidget {
  const Welcome({super.key, });

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
                  'assets/images/welcome_button.png',
                  width: 361,
                  height: 117,
                ),
                const SizedBox(height: 50),
                Image.asset(
                  'assets/images/logo_game.png',
                  width: 362,
                  height: 366,
                ),
                const SizedBox(height: 20),
                Padding(
                  padding: const EdgeInsets.only(right: 16, top: 51),
                  child: GestureDetector(
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) {
                          return const Guide();
                        }),
                      );
                    },
                    child: Image.asset(
                      'assets/images/buttons/next.png',
                      width: 300,
                    ),
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
