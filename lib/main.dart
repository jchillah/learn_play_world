import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:learn_play_world/firebase_options.dart';
import 'package:learn_play_world/src/app.dart';
import 'package:learn_play_world/src/data/auth_repository.dart.dart';
import 'package:learn_play_world/src/data/database_repository.dart';
import 'package:learn_play_world/src/data/mock_database.dart';
import 'package:provider/provider.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  DatabaseRepository databaseRepository = MockDatabase();
  AuthRepository authRepository =
      AuthRepository(FirebaseAuth.instance, options: null);

  runApp(MultiProvider(
    providers: [
      Provider<DatabaseRepository>(
        create: (context) => databaseRepository,
      ),
      Provider<AuthRepository>(
        create: (context) => authRepository,
      ),
    ],
    child: const App(),
  ));
}
