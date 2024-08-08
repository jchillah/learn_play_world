import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:learn_play_world/firebase_options.dart';
import 'package:learn_play_world/src/app.dart';
import 'package:learn_play_world/src/data/auth_repository.dart';
import 'package:learn_play_world/src/data/video_path_provider/video_path_provider.dart';
import 'package:provider/provider.dart';


void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  VideoPathProvider videoPathProvider = VideoPathProvider();
  AuthRepository authRepository =
      AuthRepository(FirebaseAuth.instance, options: null);

  runApp(MultiProvider(
    providers: [
      Provider<VideoPathProvider>(
        create: (context) => videoPathProvider,
      ),
      Provider<AuthRepository>(
        create: (context) => authRepository,
      ),
    ],
    child: const App(),
  ));
}
