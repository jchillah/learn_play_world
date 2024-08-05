import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:learn_play_world/src/config/colors/app_colors.dart';
import 'package:learn_play_world/src/data/auth_repository.dart';
import 'package:learn_play_world/src/features/authentication/application/validators.dart';
import 'package:learn_play_world/src/features/authentication/presentation/login_screen.dart';
import 'package:learn_play_world/src/features/welcome/presentation/welcome.dart';

class SignUpScreen extends StatefulWidget {
  const SignUpScreen({super.key});

  @override
  State<SignUpScreen> createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  bool showPassword = false;

  late TextEditingController _emailController;
  late TextEditingController _pwController;
  late TextEditingController _pwRepeatController;

  final GlobalKey<ScaffoldMessengerState> _scaffoldKey =
      GlobalKey<ScaffoldMessengerState>();

  @override
  void initState() {
    super.initState();
    _emailController = TextEditingController();
    _pwController = TextEditingController();
    _pwRepeatController = TextEditingController();
  }

  @override
  void dispose() {
    _emailController.dispose();
    _pwController.dispose();
    _pwRepeatController.dispose();
    super.dispose();
  }

  void _showSnackbar(String message) {
    if (mounted) {
      _scaffoldKey.currentState?.showSnackBar(SnackBar(content: Text(message)));
    }
  }

  void _handleSignUp() async {
    try {
      await context.read<AuthRepository>().signUpWithEmailAndPassword(
            _emailController.text,
            _pwController.text,
          );

      if (mounted) {
        // Snackbar muss im Widget aufgerufen werden
        WidgetsBinding.instance.addPostFrameCallback((_) {
          if (mounted) {
            _showSnackbar("Account created successfully");
            Navigator.pushReplacement(
              context,
              MaterialPageRoute(
                builder: (context) => const Welcome(),
              ),
            );
          }
        });
      }
    } catch (e) {
      if (mounted) {
        WidgetsBinding.instance.addPostFrameCallback((_) {
          if (mounted) {
            _showSnackbar("error creating account: $e");
          }
        });
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      backgroundColor: AppColors.backgroundColor,
      appBar: AppBar(
        backgroundColor: AppColors.backgroundColor,
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Form(
            child: Column(
              children: [
                Image.asset(
                  "assets/images/learn_play_world.png",
                ),
                const SizedBox(height: 20),
                TextFormField(
                  controller: _emailController,
                  validator: validateEmail,
                  autovalidateMode: AutovalidateMode.onUserInteraction,
                  decoration: const InputDecoration(
                    border: OutlineInputBorder(),
                    labelText: "Email",
                    icon: Icon(Icons.email),
                  ),
                ),
                const SizedBox(height: 32),
                TextFormField(
                  controller: _pwController,
                  validator: validatePw,
                  autovalidateMode: AutovalidateMode.onUserInteraction,
                  obscureText: !showPassword,
                  decoration: InputDecoration(
                    border: const OutlineInputBorder(),
                    labelText: "Passwort",
                    icon: const Icon(Icons.password),
                    suffixIcon: IconButton(
                      onPressed: () {
                        setState(() {
                          showPassword = !showPassword;
                        });
                      },
                      icon: showPassword
                          ? const Icon(Icons.visibility_off)
                          : const Icon(Icons.visibility),
                    ),
                  ),
                ),
                const SizedBox(height: 16),
                TextFormField(
                  controller: _pwRepeatController,
                  validator: (value) {
                    return validateRepeatPw(_pwController.text, value)
                        ? null
                        : "passwords do not match";
                  },
                  autovalidateMode: AutovalidateMode.onUserInteraction,
                  obscureText: !showPassword,
                  decoration: InputDecoration(
                    border: const OutlineInputBorder(),
                    labelText: "repeat Password",
                    icon: const Icon(Icons.password),
                    suffixIcon: IconButton(
                      onPressed: () {
                        setState(() {
                          showPassword = !showPassword;
                        });
                      },
                      icon: showPassword
                          ? const Icon(Icons.visibility_off)
                          : const Icon(Icons.visibility),
                    ),
                  ),
                ),
                const SizedBox(height: 32),
                ElevatedButton(
                  onPressed: _handleSignUp,
                  style: ElevatedButton.styleFrom(
                    backgroundColor: AppColors.buttonColor,
                  ),
                  child: const Padding(
                    padding: EdgeInsets.all(8.0),
                    child: Text("register"),
                  ),
                ),
                const SizedBox(height: 32),
                const Divider(),
                const SizedBox(height: 32),
                TextButton(
                  onPressed: () {
                    Navigator.pushReplacement(
                      context,
                      MaterialPageRoute(
                        builder: (context) => const LoginScreen(),
                      ),
                    );
                  },
                  child: const Text("You already have an account? Login here"),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
