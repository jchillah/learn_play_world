import 'package:flutter/material.dart';
import 'package:learn_play_world/src/config/colors/app_colors.dart';
import 'package:learn_play_world/src/features/game/presentation/game_farm/presentation/game_farm.dart';
import 'package:learn_play_world/src/features/game/presentation/game_jungle/presentation/game_jungle.dart';
import 'package:learn_play_world/src/features/game/presentation/game_ocean/presentation/game_ocean.dart';
import 'package:learn_play_world/src/features/introduction_guide/presentation/introduction.dart';
import 'package:learn_play_world/src/features/setting/presentation/unlock_setting_task.dart';

class Overview extends StatefulWidget {
  const Overview({
    super.key,
  });

  @override
  State<Overview> createState() => _OverviewState();
}

class _OverviewState extends State<Overview> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: AppColors.backgroundColor,
        body: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16.0),
          child: SingleChildScrollView(
              child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: <Widget>[
              Row(
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
              ),
              const SizedBox(
                height: 50,
              ),
              Image.asset(
                'assets/images/choose_game_text.png',
                width: 275,
                height: 40,
                fit: BoxFit.cover,
              ),
              const SizedBox(
                height: 50,
              ),
              GestureDetector(
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => const GameFarm(
                              levelTheme: 'Farm',
                              level: 1,
                            )),
                  );
                },
                child: Image.asset(
                  'assets/images/buttons/game/farm_button.png',
                  width: 361,
                  height: 119,
                ),
              ),
              const SizedBox(
                height: 50,
              ),
              GestureDetector(
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => const GameJungle(
                              levelTheme: 'Jungle',
                              level: 1,
                            )),
                  );
                },
                child: Image.asset(
                  'assets/images/buttons/game/jungle_button.png',
                  width: 361,
                  height: 119,
                ),
              ),
              const SizedBox(
                height: 50,
              ),
              GestureDetector(
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => const GameOcean(
                              levelTheme: 'Ocean',
                              level: 1,
                            )),
                  );
                },
                child: Image.asset(
                  'assets/images/buttons/game/ocean_button.png',
                  width: 361,
                  height: 119,
                ),
              ),
            ],
          )),
        ),
      ),
    );
  }
}
