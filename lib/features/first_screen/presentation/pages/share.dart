import 'package:flutter/material.dart';

class Share extends StatelessWidget {

  const Share({super.key});

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
                  const Positioned(
                    top: 50,
                    left: 25,
                    child: Image(
                      image: AssetImage('assets/code.png'),
                      width: 270,
                      height: 270,
                    ),
                  ),

                  Positioned(
                    top: 370,
                    left: 20,
                    right: 20,
                    child: Container(
                      padding: const EdgeInsets.all(12),
                      decoration: BoxDecoration(
                        color: const Color(0xFFFFAF76),
                        border: Border.all(
                          color: const Color(0xFFFF6C05),
                          width: 2,
                        ),
                        borderRadius: BorderRadius.circular(16),
                      ),
                      child: const Text(
                        'Ссылка',
                        textAlign: TextAlign.left,
                        style: TextStyle(
                          color: Colors.black,
                          fontSize: 16,
                          decoration: TextDecoration.none,
                          fontFamily: 'Gilroy-Medium',
                        ),
                      ),
                    ),
                  ),

                ],
              ),
            ),
          ),
        ),
      ],
    );
  }
}
