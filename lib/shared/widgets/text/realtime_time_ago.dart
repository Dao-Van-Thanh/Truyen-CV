import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter_template/i18n/strings.g.dart';

class RealtimeTimeAgo extends StatefulWidget {
  final DateTime targetTime;
  final TextStyle? style;

  const RealtimeTimeAgo({
    super.key,
    required this.targetTime,
    this.style,
  });

  @override
  State<RealtimeTimeAgo> createState() => _RealtimeTimeAgoState();
}

class _RealtimeTimeAgoState extends State<RealtimeTimeAgo> {
  Timer? _timer;

  @override
  void initState() {
    super.initState();
    _timer = Timer.periodic(const Duration(minutes: 1), (timer) {
      if (!mounted) return;
      setState(() {});

      final diff = DateTime.now().difference(widget.targetTime);
      if (diff.inDays > 1) {
        timer.cancel();
      }
    });
  }

  @override
  void dispose() {
    _timer?.cancel();
    super.dispose();
  }

  String _formatTime(BuildContext context, DateTime time) {
    try {
      final t = context.t;

      final now = DateTime.now();
      final difference = now.difference(time);

      if (difference.inSeconds < 60) {
        return t.common.justNow;
      } else if (difference.inMinutes < 60) {
        return '${difference.inMinutes} ${t.common.minuteAgo}';
      } else if (difference.inHours < 24) {
        return '${difference.inHours} ${t.common.hourAgo}';
      } else if (difference.inDays < 7) {
        return '${difference.inDays} ${t.common.dayAgo}';
      } else {
        return '${time.day}/${time.month}/${time.year}';
      }
    } catch (e) {
      return '';
    }
  }

  @override
  Widget build(BuildContext context) {
    return Text(
      _formatTime(context, widget.targetTime),
      style: widget.style,
    );
  }
}
