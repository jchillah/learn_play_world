import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:learn_play_world/src/config/colors/app_colors.dart';
import 'package:learn_play_world/src/features/authentication/presentation/login_screen.dart';
import 'package:learn_play_world/src/features/overview/presentation/overview.dart';
import 'package:learn_play_world/src/features/setting/domain/language.dart';

class Setting extends StatefulWidget {
  const Setting({super.key});

  @override
  SettingState createState() => SettingState();
}

class SettingState extends State<Setting> {
  Language dropdownValue = Language.deutsch;
  final TextEditingController _usernameController = TextEditingController();
  User? currentUser;

  @override
  void initState() {
    super.initState();
    currentUser = FirebaseAuth.instance.currentUser;
    if (currentUser != null) {
      _fetchUserSettings();
    }
  }

  Future<void> _fetchUserSettings() async {
    try {
      DocumentSnapshot userDoc = await FirebaseFirestore.instance
          .collection('users')
          .doc(currentUser!.uid)
          .get();

      if (userDoc.exists && userDoc.data() != null) {
        final username = userDoc['username'] ?? '';
        final language = userDoc['language'] ?? 'de';

        if (mounted) {
          setState(() {
            _usernameController.text = username;
            dropdownValue = LanguageExtension.fromString(language);
          });
        }
      } else {
        if (mounted) {
          setState(() {
            _usernameController.text = 'Kein Benutzername gefunden';
            dropdownValue = Language.deutsch;
          });
        }
      }
    } catch (e) {
      debugPrint('Fehler beim Abrufen der Benutzereinstellungen: $e');

      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text(
                'Fehler beim Laden der Benutzereinstellungen. Bitte versuche es später erneut.'),
            duration: Duration(seconds: 3),
          ),
        );
      }
    }
  }

  Future<void> _saveUserSettings() async {
    if (currentUser != null) {
      try {
        await FirebaseFirestore.instance
            .collection('users')
            .doc(currentUser!.uid)
            .set({
          'username': _usernameController.text,
          'language': dropdownValue.stringValue,
        }, SetOptions(merge: true));

        if (mounted) {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(
              content: Text('Benutzereinstellungen erfolgreich gespeichert'),
              duration: Duration(seconds: 2),
            ),
          );
        }
      } catch (e) {
        debugPrint('Fehler beim Speichern der Benutzereinstellungen: $e');

        if (mounted) {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(
              content: Text(
                  'Fehler beim Speichern der Benutzereinstellungen. Bitte versuche es später erneut.'),
              duration: Duration(seconds: 3),
            ),
          );
        }
      }
    }
  }

  void _logout() async {
    await FirebaseAuth.instance.signOut();
    if (mounted) {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(
          builder: (context) => const LoginScreen(),
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.backgroundColor,
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
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
                      padding: const EdgeInsets.symmetric(
                          horizontal: 18, vertical: 5),
                      child: DropdownButtonHideUnderline(
                        child: DropdownButton<Language>(
                          value: dropdownValue,
                          icon: const Icon(Icons.arrow_drop_down_sharp),
                          iconSize: 24,
                          elevation: 16,
                          style: const TextStyle(color: Colors.white),
                          dropdownColor: AppColors.textColor,
                          onChanged: (Language? newValue) {
                            setState(() {
                              dropdownValue = newValue!;
                              _saveUserSettings();
                            });
                          },
                          items: Language.values
                              .map<DropdownMenuItem<Language>>(
                                  (Language value) {
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
              Padding(
                padding: const EdgeInsets.all(16.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    const Text(
                      'Spielername:',
                      style: TextStyle(
                        color: AppColors.textColor,
                        fontSize: 24,
                        fontWeight: FontWeight.bold,
                        fontFamily: 'Holtwood SC',
                      ),
                    ),
                    const Spacer(),
                    Expanded(
                      child: Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 8.0),
                        child: TextField(
                          controller: _usernameController,
                          style: const TextStyle(
                            color: Colors.white,
                          ),
                          decoration: const InputDecoration(
                            border: OutlineInputBorder(),
                            fillColor: AppColors.textColor,
                            filled: true,
                            hintText: 'Enter your username',
                            hintStyle: TextStyle(color: AppColors.buttonColor),
                          ),
                          onEditingComplete: _saveUserSettings,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              ElevatedButton(
                onPressed: _saveUserSettings,
                style: ElevatedButton.styleFrom(
                  backgroundColor: AppColors.buttonColor,
                  textStyle: const TextStyle(color: Colors.white),
                ),
                child: const Text('Save'),
              ),
              const SizedBox(
                height: 20,
              ),
              Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'E-Mail: ${currentUser?.email ?? 'Nicht eingeloggt'}',
                      style: const TextStyle(
                        color: AppColors.textColor,
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 8),
                    Text(
                      'UID: ${currentUser?.uid ?? 'Nicht eingeloggt'}',
                      style: const TextStyle(
                        color: AppColors.textColor,
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 32),
              ElevatedButton(
                onPressed: _logout,
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0xFFBADE02), // Button color
                ),
                child: const Padding(
                  padding: EdgeInsets.all(8.0),
                  child: Text('Logout'),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
