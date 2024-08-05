enum Language { deutsch, english, french }

extension LanguageExtension on Language {
  String get displayValue {
    switch (this) {
      case Language.deutsch:
        return 'Deutsch';
      case Language.english:
        return 'English';
      case Language.french:
        return 'Français';
    }
  }

  String get stringValue {
    switch (this) {
      case Language.deutsch:
        return 'de';
      case Language.english:
        return 'en';
      case Language.french:
        return 'fr';
    }
  }

  static Language fromString(String value) {
    switch (value) {
      case 'de':
        return Language.deutsch;
      case 'en':
        return Language.english;
      case 'fr':
        return Language.french;
      default:
        return Language
            .deutsch; // Default to German if the value is unrecognized
    }
  }
}
