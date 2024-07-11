import 'dart:math';

import 'package:flutter/material.dart';
import 'package:learn_play_world/src/config/colors/app_colors.dart';
import 'package:learn_play_world/src/features/setting/presentation/setting.dart';

class UnlockSettingTask extends StatefulWidget {
  const UnlockSettingTask({super.key});

  @override
  UnlockSettingTaskState createState() => UnlockSettingTaskState();
}

class UnlockSettingTaskState extends State<UnlockSettingTask> {
  late int num1;
  late int num2;
  late int result;
  final TextEditingController nameController = TextEditingController();

  @override
  void initState() {
    super.initState();
    num1 = Random().nextInt(10);
    num2 = Random().nextInt(10);
    result = num1 * num2;
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: AppColors.backgroundColor,
        body: Center(
          child: Container(
            padding: const EdgeInsets.all(20),
            decoration: const BoxDecoration(
              color: Colors.white,
            ),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    GestureDetector(
                      onTap: () {
                        Navigator.pop(context);
                      },
                      child: Image.asset(
                        'assets/images/buttons/close_button.png',
                        width: 40,
                        height: 60,
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 20),
                const Text(
                  'KINDERSICHERUNG - EINSTELLUNGEN',
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 10),
                const Text(
                  'Dieser Bereich ist den Eltern vorbehalten. Bitte geben Sie das richtige Ergebnis ein:',
                  style: TextStyle(fontSize: 14),
                ),
                const SizedBox(height: 10),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      '$num1 x $num2:',
                      style: const TextStyle(fontSize: 14),
                    ),
                    const SizedBox(width: 10),
                    Container(
                      width: 100,
                      height: 50,
                      decoration: BoxDecoration(
                        border: Border.all(color: Colors.grey),
                        borderRadius: BorderRadius.circular(5),
                      ),
                      child: TextField(
                        style: const TextStyle(fontSize: 14),
                        controller: nameController,
                        keyboardType: TextInputType.number,
                        textAlign: TextAlign.center,
                        decoration: const InputDecoration(
                          helperStyle: TextStyle(fontSize: 14),
                          border: InputBorder.none,
                          contentPadding: EdgeInsets.zero,
                        ),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 20),
                GestureDetector(
                  onTap: () {
                    if (nameController.text.isEmpty) {
                      showDialog(
                        context: context,
                        builder: (BuildContext context) {
                          return AlertDialog(
                            title: const Text("Falsches Ergebnis"),
                            content: const Text(
                                "Das Ergebnis ist falsch. Versuchen Sie es erneut."),
                            actions: [
                              TextButton(
                                onPressed: () {
                                  Navigator.pop(context);
                                },
                                child: const Text("OK"),
                              ),
                            ],
                          );
                        },
                      );
                    } else if (int.parse(nameController.text) == result) {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => const Setting(),
                        ),
                      );
                    } else {
                      showDialog(
                        context: context,
                        builder: (BuildContext context) {
                          return AlertDialog(
                            title: const Text("Falsches Ergebnis"),
                            content: const Text(
                                "Das Ergebnis ist falsch. Versuchen Sie es erneut."),
                            actions: [
                              TextButton(
                                onPressed: () {
                                  Navigator.pop(
                                      context); // Schließe das Dialogfenster
                                },
                                child: const Text("OK"),
                              ),
                            ],
                          );
                        },
                      );
                    }
                  },
                  child: Image.asset(
                    "assets/images/buttons/next.png",
                    width: 300.0,
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
