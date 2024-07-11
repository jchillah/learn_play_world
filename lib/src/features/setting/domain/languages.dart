enum Language {
  deutsch,
  englisch;

  String get displayValue {
    switch (this) {
      case Language.deutsch:
        return 'German';
      case Language.englisch:
        return 'English';
      default:
        return 'Unknown';
    }
  }
}
