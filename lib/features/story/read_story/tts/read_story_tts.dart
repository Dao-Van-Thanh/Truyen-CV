import 'dart:io';

import 'package:flutter_template/features/story/read_story/enum/read_tts_status.dart';
import 'package:flutter_template/features/story/read_story/model/tts_config_model.dart';
import 'package:flutter_template/shared/utilities/logger.dart';
import 'package:flutter_tts/flutter_tts.dart';
import 'package:rxdart/rxdart.dart';

class ReadStoryTts {
  late final FlutterTts _flutterTts;

  final _currentIndexSubject = BehaviorSubject<int>.seeded(0);

  Stream<int> get currentIndexStream => _currentIndexSubject.stream;
  int get currentIndex => _currentIndexSubject.value;

  ReadTtsStatus _status = ReadTtsStatus.stopped;
  List<String> _paragraphs = [];
  String _currentChapterId = '';
  String get currentChapterId => _currentChapterId;
  void Function(int index)? onParagraphChanged;
  void Function()? onChapterFinished;

  Future<void> initTts() async {
    _flutterTts = FlutterTts();
    await _flutterTts.awaitSpeakCompletion(true);
    await Future.wait([
      _flutterTts.setSpeechRate(0.5), // tốc độ đọc 0.0 - 1.0 default 0.5
      _flutterTts.setVolume(1.0), // âm lượng 0.0 - 1.0
      _flutterTts.setPitch(1.0), // độ cao giọng 0.5 - 2.0
      _flutterTts.setIosAudioCategory(
        IosTextToSpeechAudioCategory.playback,
        [
          IosTextToSpeechAudioCategoryOptions.defaultToSpeaker,
          IosTextToSpeechAudioCategoryOptions.allowBluetooth,
          IosTextToSpeechAudioCategoryOptions.allowBluetoothA2DP,
        ],
      ),
    ]);

    if (Platform.isAndroid) {
      await Future.delayed(const Duration(seconds: 1));
    }

    _flutterTts.setCompletionHandler(() {
      // Khi đọc xong 1 đoạn, hàm này sẽ chạy
      _next();
    });
  }

  Future<List<Map<String, String>>> getVoices() async {
    try {
      final rawVoices = await _flutterTts.getVoices;
      if (rawVoices == null) return [];
      final List<Map<String, String>> cleanVoices = [];

      for (final element in rawVoices) {
        final voice = Map<String, dynamic>.from(element as Map);

        final String name = voice['name'].toString();
        final String locale = voice['locale'].toString();

        // Xử lý tên hiển thị
        String displayName = name; // Mặc định lấy tên gốc: vi-vn-x-gft-local

        // Logic check Online (Android)
        if (voice.containsKey('network_required')) {
          final isNetwork = voice['network_required'].toString() == '1';
          if (isNetwork) {
            displayName = '$name (Online)'; // Thêm tag (Online)
          }
        }

        // Logic check Enhanced (iOS)
        if (voice.containsKey('quality')) {
          final quality = voice['quality'].toString();
          if (quality == '1' || quality == 'enhanced') {
            displayName = '$name (Enhanced)';
          }
        }

        cleanVoices.add({
          'name': name, // ID định danh
          'locale': locale, // Nhóm ngôn ngữ
          'display': displayName, // Tên hiển thị UI
        });
      }

      // Sắp xếp danh sách cho đẹp (Locale trước, sau đó đến Name)
      cleanVoices.sort((a, b) {
        final int cmp = (a['locale'] ?? '').compareTo(b['locale'] ?? '');
        if (cmp != 0) return cmp;
        return (a['name'] ?? '').compareTo(b['name'] ?? '');
      });

      final defaultLang = 'vi-VN';

      await _flutterTts.setLanguage(
        cleanVoices.firstWhere(
              (e) => e['locale'] == defaultLang,
              orElse: () => cleanVoices.first,
            )['locale'] ??
            defaultLang,
      );

      return cleanVoices;
    } catch (e) {
      logger.e('Error getting TTS voices: $e');
      return [];
    }
  }

  void setData(List<String> paragraphs, {int startIndex = 0}) {
    _paragraphs = paragraphs;
    _currentIndexSubject.value = startIndex;
  }

  void dispose() {
    _flutterTts.stop();
    _currentIndexSubject.close();
  }

  Future<void> play(String chapterId) async {
    if (_paragraphs.isEmpty) return;
    if (currentIndex >= _paragraphs.length) {
      // Đã hết chương
      onChapterFinished?.call();
      return;
    }

    _status = ReadTtsStatus.playing;
    // Báo ra ngoài UI update highlight
    onParagraphChanged?.call(currentIndex);

    // Đọc đoạn hiện tại
    _currentChapterId = chapterId;
    await _flutterTts.speak(_paragraphs[currentIndex]);
  }

  Future<void> playToIndex(int index, String chapterId) async {
    if (index < 0 || index >= _paragraphs.length) return;

    await pause();

    _currentIndexSubject.value = index;
    _currentChapterId = chapterId;
    await Future.delayed(const Duration(milliseconds: 200));
    await play(chapterId);
  }

  // Tự động chuyển đoạn tiếp theo (Internal use)
  void _next() {
    if (!_status.isPlaying) return; // Nếu user đã pause thì không next

    if (currentIndex < _paragraphs.length - 1) {
      _currentIndexSubject.value += 1;

      play(_currentChapterId); // Đệ quy: Gọi lại hàm play cho index mới
    } else {
      // Hết danh sách
      onChapterFinished?.call();
    }
  }

  // Các hàm điều khiển thủ công
  Future<void> pause() async {
    _status = ReadTtsStatus.paused;
    await _flutterTts.stop();
  }

  Future<void> stop() async {
    _status = ReadTtsStatus.stopped;
    _currentIndexSubject.value = 0;
    await _flutterTts.stop();
  }

  Future<void> nextParagraph() async {
    if (currentIndex < _paragraphs.length - 1) {
      playToIndex(currentIndex + 1, _currentChapterId);
    }
  }

  Future<void> previousParagraph() async {
    if (currentIndex > 0) {
      playToIndex(currentIndex - 1, _currentChapterId);
    }
  }

  Future<void> setConfig(TtsConfig config) async {
    await Future.wait([
      _flutterTts.setSpeechRate(config.rate),
      _flutterTts.setPitch(config.pitch),
      _flutterTts.setVolume(config.volume),
      config.selectedVoice != null
          ? _flutterTts.setVoice({
              'name': config.selectedVoice!['name'] ?? '',
              'locale': config.selectedLanguage,
            })
          : _flutterTts.clearVoice(), // Reset về giọng mặc định
    ]);
  }

  Future<void> previewVoice(TtsConfig config) async {
    setConfig(config);
    await pause();
    _flutterTts.setCompletionHandler(() {});
    await _flutterTts
        .speak('Alo Alo, một hai ba bốn năm sáu bảy tám chín mười.');
    _flutterTts.setCompletionHandler(_next);
  }

  Future<List<String>> getEngines() async {
    try {
      if (Platform.isIOS) return []; // iOS không hỗ trợ đổi engine
      final engines = await _flutterTts.getEngines;
      if (engines != null) {
        return List<String>.from(engines);
      }
      return [];
    } catch (e) {
      logger.e('Error getting TTS engines: $e');
      return [];
    }
  }

  Future<String?> getDefaultEngine() async {
    try {
      if (Platform.isIOS) return null;
      return await _flutterTts.getDefaultEngine;
    } catch (e) {
      return null;
    }
  }

  Future<void> setEngine(String enginePackageName) async {
    if (Platform.isIOS) return;
    await _flutterTts.setEngine(enginePackageName);
  }
}
