import 'package:flutter/material.dart';
import 'package:learn_play_world/src/features/introduction_guide/presentation/introduction.dart';
import 'package:learn_play_world/src/features/setting/presentation/unlock_setting_task.dart';

class MenuRow extends StatelessWidget {
  const MenuRow({super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: <Widget>[
        GestureDetector(
          onTap: () {
            showModalBottomSheet(
              context: context,
              builder: (context) {
                return const Introduction();
              },
            );
          },
          child: Image.asset(
            'assets/images/buttons/questionmark.png',
            width: 80,
            height: 120,
            fit: BoxFit.contain,
          ),
        ),
        const Spacer(),
        GestureDetector(
          onTap: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (context) => const UnlockSettingTask()),
            );
          },
          child: Image.asset(
            'assets/images/buttons/settings_button.png',
            width: 80,
            height: 120,
            fit: BoxFit.contain,
          ),
        ),
      ],
    );
  }
}
