import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:learn_play_world/src/config/colors/app_colors.dart';
import 'package:learn_play_world/src/features/authentication/presentation/login_screen.dart';
import 'package:learn_play_world/src/features/splash_screen/presentation/splash_screen.dart';
import 'package:learn_play_world/src/features/welcome/presentation/welcome.dart';

class App extends StatelessWidget {
  const App({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: StreamBuilder<User?>(
        stream: FirebaseAuth.instance.authStateChanges(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          } else if (snapshot.hasData) {
            return const Welcome();
          } else {
            return SplashScreen(
              duration: 3,
              navigateAfterSeconds: const LoginScreen(),
              image: Image.asset('assets/images/logo_game.png'),
              backgroundColor: AppColors.backgroundColor,
              loaderColor: AppColors.backgroundColor,
            );
          }
        },
      ),
    );
  }
}
