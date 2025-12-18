import 'package:flutter_template/features/story/read_story/enum/read_tts_status.dart';
import 'package:flutter_tts/flutter_tts.dart';
import 'package:rxdart/rxdart.dart';

class ReadStoryTts {
  final FlutterTts _flutterTts = FlutterTts();

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
    await Future.wait([
      _flutterTts.setLanguage('vi-VN'),
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
    _flutterTts.setCompletionHandler(() {
      // Khi đọc xong 1 đoạn, hàm này sẽ chạy
      _next();
    });
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
}
