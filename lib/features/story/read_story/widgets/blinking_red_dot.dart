import 'package:flutter/material.dart';

class BlinkingRedDot extends StatefulWidget {
  const BlinkingRedDot({super.key});

  @override
  State<BlinkingRedDot> createState() => _BlinkingRedDotState();
}

class _BlinkingRedDotState extends State<BlinkingRedDot>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _animation;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: const Duration(milliseconds: 800),
      vsync: this,
    )..repeat(reverse: true);

    _animation = CurvedAnimation(
      parent: _controller,
      curve: Curves.easeInOut,
    );
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return FadeTransition(
      opacity: _animation,
      child: Container(
        width: 10,
        height: 10,
        decoration: BoxDecoration(
          color: Colors.red, // Màu đỏ
          shape: BoxShape.circle,
          border: Border.all(color: Colors.white, width: 1.5),
          boxShadow: [
            BoxShadow(
              color: Colors.red.withValues(alpha: 0.6),
              blurRadius: 4,
              spreadRadius: 1,
            )
          ],
        ),
      ),
    );
  }
}
