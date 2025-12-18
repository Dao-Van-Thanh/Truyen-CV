enum ReadTtsStatus {
  stopped,
  playing,
  paused;

  bool get isPlaying => this == ReadTtsStatus.playing;
  bool get isStopped => this == ReadTtsStatus.stopped;
}
