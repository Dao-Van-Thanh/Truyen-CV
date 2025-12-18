class TtsConfig {
  static const double defaultRate = 0.5;
  static const double defaultPitch = 1.0;
  static const double defaultVolume = 1.0;

  final double rate;
  final double pitch;
  final double volume;
  final Map<String, String>? selectedVoice; // Giọng
  final String selectedLanguage; // Ngôn ngữ
  final List<Map<String, String>>
      availableVoices; // Toàn bộ danh sách giọng (All languages)

  TtsConfig({
    this.rate = defaultRate,
    this.pitch = defaultPitch,
    this.volume = defaultVolume,
    this.selectedVoice,
    this.selectedLanguage = 'vi-VN', // Mặc định là tiếng Việt
    this.availableVoices = const [],
  });

  // Lấy danh sách các ngôn ngữ duy nhất để hiển thị Dropdown Ngôn ngữ
  List<String> get uniqueLanguages {
    final languages =
        availableVoices.map((e) => e['locale'] ?? '').toSet().toList();
    languages.sort(); // Sắp xếp A-Z
    return languages.where((e) => e.isNotEmpty).toList();
  }

  //  Lấy danh sách giọng thuộc ngôn ngữ đang chọn
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
  }) {
    return TtsConfig(
      rate: rate ?? this.rate,
      pitch: pitch ?? this.pitch,
      volume: volume ?? this.volume,
      selectedVoice: selectedVoice ?? this.selectedVoice,
      selectedLanguage: selectedLanguage ?? this.selectedLanguage,
      availableVoices: availableVoices ?? this.availableVoices,
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
