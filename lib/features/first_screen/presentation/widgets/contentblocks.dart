import 'package:flutter/material.dart';

class BackgroundLayout extends StatelessWidget {
  final Widget child;

  const BackgroundLayout({super.key, required this.child});

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        // Фоновая картинка
        const Positioned.fill(
          child: Image(
            image: AssetImage('assets/fon1.png'),
            fit: BoxFit.cover,
          ),
        ),

        // Полупрозрачный прямоугольник
        Positioned.fill(
          child: Container(
            color: Colors.white.withOpacity(0.3),
          ),
        ),

        // Второй прямоугольник (по центру)
        Positioned.fill(
          child: Center(
            child: Container(
              width: 320,
              height: 600,
              decoration: BoxDecoration(
                color: const Color(0xFF4B4B4B),
                borderRadius: BorderRadius.circular(24),
              ),
              child: Stack(
                children: [
                  // Прямоугольник сверху по центру
                  Positioned(
                    top: 36,
                    left: 16,
                    right: 16,
                    child: Center(
                      child: Container(
                        width: 350,
                        height: 60,
                        decoration: BoxDecoration(
                          color: const Color(0xFFFFD5B8),
                          borderRadius: BorderRadius.circular(16),
                        ),
                      ),
                    ),
                  ),
                  child// содержимое текущего окна
                ],
              ),
            ),
          ),
        ),
      ],
    );
  }
}
