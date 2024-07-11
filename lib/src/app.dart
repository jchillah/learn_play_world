import 'package:flutter/material.dart';
import 'package:learn_play_world/src/config/colors/app_colors.dart';
import 'package:learn_play_world/src/features/authentication/presentation/login_screen.dart';
import 'package:learn_play_world/src/features/splash_screen/presentation/splash_screen.dart';

class App extends StatelessWidget {
  
  const App({super.key, });

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: SplashScreen(
        duration: 3,
        navigateAfterSeconds: const LoginScreen(),
        image: Image.asset('assets/images/logo_game.png'),
        backgroundColor: AppColors.backgroundColor,
        loaderColor: AppColors.backgroundColor,
      ),
    );
  }
}
