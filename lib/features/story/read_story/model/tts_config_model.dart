class TtsConfig {
  static const double defaultRate = 0.5;
  static const double defaultPitch = 1.0;
  static const double defaultVolume = 1.0;

  final double rate;
  final double pitch;
  final double volume;
  final Map<String, String>? selectedVoice;
  final String selectedLanguage;
  final List<Map<String, String>> availableVoices;

  final String? selectedEngine; // Ví dụ: com.google.android.tts
  final List<String> availableEngines; // Danh sách các engine trong máy

  TtsConfig({
    this.rate = defaultRate,
    this.pitch = defaultPitch,
    this.volume = defaultVolume,
    this.selectedVoice,
    this.selectedLanguage = 'vi-VN',
    this.availableVoices = const [],
    this.selectedEngine,
    this.availableEngines = const [],
  });

  List<String> get uniqueLanguages {
    final languages =
        availableVoices.map((e) => e['locale'] ?? '').toSet().toList();
    languages.sort();
    return languages.where((e) => e.isNotEmpty).toList();
  }

  List<Map<String, String>> get voicesForSelectedLanguage {
    return availableVoices
        .where((e) => e['locale'] == selectedLanguage)
        .toList();
  }

  TtsConfig copyWith({
    double? rate,
    double? pitch,
    double? volume,
    Map<String, String>? selectedVoice,
    String? selectedLanguage,
    List<Map<String, String>>? availableVoices,
    String? selectedEngine,
    List<String>? availableEngines,
  }) {
    return TtsConfig(
      rate: rate ?? this.rate,
      pitch: pitch ?? this.pitch,
      volume: volume ?? this.volume,
      selectedVoice: selectedVoice ?? this.selectedVoice,
      selectedLanguage: selectedLanguage ?? this.selectedLanguage,
      availableVoices: availableVoices ?? this.availableVoices,
      selectedEngine: selectedEngine ?? this.selectedEngine,
      availableEngines: availableEngines ?? this.availableEngines,
    );
  }

  TtsConfig resetAudioSettings() {
    return copyWith(
      rate: defaultRate,
      pitch: defaultPitch,
      volume: defaultVolume,
    );
  }
}
