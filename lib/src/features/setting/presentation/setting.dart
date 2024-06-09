import 'package:flutter/material.dart';
import 'package:learn_play_world/src/config/colors/app_colors.dart';
import 'package:learn_play_world/src/features/overview/presentation/overview.dart';
import 'package:learn_play_world/src/features/setting/domain/languages.dart';

class Setting extends StatefulWidget {
  const Setting({super.key});

  @override
  SettingState createState() => SettingState();
}

class SettingState extends State<Setting> {
  Language dropdownValue = Language.deutsch;

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: AppColors.backgroundColor,
        body: Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  IconButton(
                    iconSize: 48,
                    onPressed: () {},
                    icon: const Icon(Icons.star_border_purple500_sharp),
                  ),
                  const Spacer(),
                  GestureDetector(
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => const Overview(),
                        ),
                      );
                    },
                    child: Image.asset(
                      'assets/images/buttons/close_button.png',
                      width: 60,
                      height: 70,
                    ),
                  ),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  const Text(
                    'Sprache:',
                    style: TextStyle(
                      color: AppColors.textColor,
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                      fontFamily: 'Holtwood SC',
                    ),
                  ),
                  const Spacer(),
                  Container(
                    decoration: const BoxDecoration(
                      color: AppColors.textColor,
                    ),
                    padding:
                        const EdgeInsets.symmetric(horizontal: 18, vertical: 5),
                    child: DropdownButtonHideUnderline(
                      child: DropdownButton<Language>(
                        focusColor: AppColors.textColor,
                        value: dropdownValue,
                        icon: const Icon(Icons.arrow_drop_down_sharp),
                        iconSize: 24,
                        elevation: 16,
                        style: const TextStyle(color: Colors.white),
                        dropdownColor: AppColors.textColor,
                        onChanged: (Language? newValue) {
                          setState(() {
                            dropdownValue = newValue!;
                          });
                        },
                        items: Language.values
                            .map<DropdownMenuItem<Language>>((Language value) {
                          return DropdownMenuItem<Language>(
                            value: value,
                            child: Text(value.displayValue),
                          );
                        }).toList(),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
