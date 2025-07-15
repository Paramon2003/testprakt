import 'dart:async';
import 'dart:math';

import 'package:flutter/material.dart';

class AnimatedFoxContainer extends StatefulWidget {
  const AnimatedFoxContainer({super.key});

  @override
  State<AnimatedFoxContainer> createState() => _AnimatedFoxContainerState();
}

class _AnimatedFoxContainerState extends State<AnimatedFoxContainer>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _rotationAnimation;
  bool _showFirstImage = true;

  @override
  void initState() {
    super.initState();

    _controller = AnimationController(
      duration: const Duration(milliseconds: 550),
      vsync: this,
    );

    _rotationAnimation = Tween<double>(
      begin: 0.0,
      end: 3.65 * pi / 180,
    ).animate(CurvedAnimation(
      parent: _controller,
      curve: Curves.easeInOut,
    ));

    _startLoop();
  }

  Future<void> _startLoop() async {
    while (mounted) {
      await _controller.forward();
      setState(() => _showFirstImage = false);
      await Future.delayed(const Duration(milliseconds: 550));
      await _controller.reverse();
      setState(() => _showFirstImage = true);
      await Future.delayed(const Duration(milliseconds: 550));
    }
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  Widget _buildContainer() {
    return Container(
      width: 260,
      height: 350,
      decoration: BoxDecoration(
        color: const Color(0xFF4B4B4B),
        borderRadius: BorderRadius.circular(24),
      ),
      child: Stack(
        children: const [
          Positioned(
            top: 15,
            left: 16,
            child: Text(
              'Вы также можете',
              style: TextStyle(
                fontFamily: 'Gilroy',
                fontSize: 24,
                color: Colors.white,
              ),
            ),
          ),
          Positioned(
            top: 50,
            left: 16,
            child: Text(
              'свайпать,',
              style: TextStyle(
                fontFamily: 'Gilroy',
                fontSize: 24,
                color: Color(0xFFFF6C05),
              ),
            ),
          ),
          Positioned(
            top: 80,
            left: 16,
            child: Text(
              'так будет легче',
              style: TextStyle(
                fontFamily: 'Gilroy',
                fontSize: 24,
                color: Colors.white,
              ),
            ),
          ),
          Positioned(
            top: 110,
            left: 16,
            child: Text(
              'проходить наш тест!',
              style: TextStyle(
                fontFamily: 'Gilroy',
                fontSize: 24,
                color: Colors.white,
              ),
            ),
          ),
        ],
      ),
    );
  }

  // заменяем _buildImage
  Widget _buildImage() {
    return Positioned(
      top: 152,
      left: 50,
      child: AnimatedCrossFade(
        firstChild: Image.asset('assets/test1.png', width: 200, height: 200),
        secondChild: Image.asset('assets/test12.png', width: 200, height: 200),
        crossFadeState: _showFirstImage
            ? CrossFadeState.showFirst
            : CrossFadeState.showSecond,
        duration: const Duration(milliseconds: 550),
      ),
    );
  }


  @override
  Widget build(BuildContext context) {
    return Stack(
      clipBehavior: Clip.none,
      children: [
        AnimatedBuilder(
          animation: _rotationAnimation,
          builder: (context, child) {
            return Transform.rotate(
              angle: _rotationAnimation.value,
              child: child,
            );
          },
          child: _buildContainer(),
        ),
        _buildImage(),
      ],
    );

  }
}
