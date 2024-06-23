import 'package:flutter/material.dart';

class AppColors {
  // Hintergrundfarben
  static const Color backgroundColor = Color(0xFFFFFFE4);

  // Schriftfarben
  static const Color textColor = Color.fromRGBO(
    53,
    43,
    83,
    1,
  );

  // Buttonfarben
  static const Color buttonColor = Color.fromRGBO(
    186,
    222,
    2,
    1,
  ); // Beispielwert für eine Farbe

  // Containerfarbe wenn man die falsche Antwort wählt
  static const Color answerButtonColor = Color.fromARGB(
    255,
    255,
    255,
    255,
  );

  static const Color correctAnswerButtonColor = Color.fromARGB(
    255,
    255,
    255,
    255,
  );

  static const Color wrongAnswerButtonColor = Color.fromRGBO(247, 15, 15, 0.4);
}
