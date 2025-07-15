import 'dart:async';
import 'dart:math';

import 'package:flutter/material.dart';

class SwipeAnimation extends StatefulWidget {
  const SwipeAnimation({super.key});

  @override
  State<SwipeAnimation> createState() => _SwipeAnimation();
}

class _SwipeAnimation extends State<SwipeAnimation> with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _rotationAnimation;
  bool _showFirstImage = true;

  @override
  void initState() {
    super.initState();

    _controller = AnimationController(
      duration: const Duration(milliseconds: 300),
      vsync: this,
    );

    _rotationAnimation = Tween<double>(
      begin: 0.0,
      end: -3 * pi / 180, // -3 градуса в радианах
    ).animate(CurvedAnimation(
      parent: _controller,
      curve: Curves.easeInOut,
    ));

    _startLoop();
  }

  void _startLoop() async {
    while (mounted) {
      await _controller.forward();
      await Future.delayed(const Duration(milliseconds: 300));
      setState(() => _showFirstImage = !_showFirstImage);
      await _controller.reverse();
      await Future.delayed(const Duration(milliseconds: 300));
    }
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: _rotationAnimation,
      builder: (context, child) {
        return Transform.rotate(
          angle: _showFirstImage ? 0 : _rotationAnimation.value,
          child: Image.asset(
            _showFirstImage ? 'assets/test1.png' : 'assets/test12.png',
            width: 200,
            height: 200,
          ),
        );
      },
    );
  }
}
