import 'package:flutter_tts/flutter_tts.dart';
import 'package:rxdart/rxdart.dart';

class ReadStoryTts {
  final FlutterTts _flutterTts = FlutterTts();

  final _currentIndexSubject = BehaviorSubject<int>.seeded(0);

  Stream<int> get currentIndexStream => _currentIndexSubject.stream;
  int get _currentIndex => _currentIndexSubject.value;

  List<String> _paragraphs = [];
  bool _isPlaying = false;
  Function(int index)? onParagraphChanged;
  Function()? onChapterFinished;

  Future<void> initTts({required List<String> paragraphs}) async {
    await Future.wait([
      _flutterTts.setLanguage('vi-VN'),
      _flutterTts.setSpeechRate(1), // tốc độ đọc 0.0 - 1.0 default 0.5
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

    // Xử lý khi user bấm stop hoặc pause
    _flutterTts.setCancelHandler(() {
      _isPlaying = false;
    });

    _flutterTts.setPauseHandler(() {
      _isPlaying = false;
    });

    _flutterTts.setContinueHandler(() {
      _isPlaying = true;
    });
    setData(paragraphs);
  }

  void setData(List<String> paragraphs, {int startIndex = 0}) {
    _paragraphs = paragraphs;
    _currentIndexSubject.value = startIndex;
  }

  void dispose() {
    _flutterTts.stop();
    _currentIndexSubject.close();
  }

  Future<void> play() async {
    if (_paragraphs.isEmpty) return;
    if (_currentIndex >= _paragraphs.length) {
      // Đã hết chương
      onChapterFinished?.call();
      return;
    }

    _isPlaying = true;
    // Báo ra ngoài UI update highlight
    onParagraphChanged?.call(_currentIndex);

    // Đọc đoạn hiện tại
    await _flutterTts.speak(_paragraphs[_currentIndex]);
  }

  Future<void> playToIndex(int index) async {
    if (index < 0 || index >= _paragraphs.length) return;
    _currentIndexSubject.value = index;
    await play();
  }

  // Tự động chuyển đoạn tiếp theo (Internal use)
  void _next() {
    if (!_isPlaying) return; // Nếu user đã pause thì không next

    if (_currentIndex < _paragraphs.length - 1) {
      _currentIndexSubject.value += 1;
      play(); // Đệ quy: Gọi lại hàm play cho index mới
    } else {
      // Hết danh sách
      _isPlaying = false;
      onChapterFinished?.call();
    }
  }

  // Các hàm điều khiển thủ công
  Future<void> pause() async {
    _isPlaying = false;
    await _flutterTts.pause();
  }

  Future<void> stop() async {
    _isPlaying = false;
    _currentIndexSubject.value = 0;
    await _flutterTts.stop();
  }

  Future<void> nextParagraph() async {
    await _flutterTts.stop(); // Stop đoạn đang đọc dở
    if (_currentIndex < _paragraphs.length - 1) {
      _currentIndexSubject.value += 1;
      play();
    }
  }

  Future<void> previousParagraph() async {
    await _flutterTts.stop();
    if (_currentIndex > 0) {
      _currentIndexSubject.value -= 1;
      play();
    }
  }
}
