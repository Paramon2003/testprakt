import 'package:flutter/material.dart';

class Basic extends StatelessWidget {
  final List<String> traits = [
    'сверхконтроль',
    'пессимистичность',
    'эмоциональная лабильность',
    'импульсивность',
    'муж-жен',
    'ригидность',
    'тревожность',
    'индивидуалистичность',
    'оптимистичность',
    'интроверсия',
  ];

  Basic({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      minimum: const EdgeInsets.only(top: 150, bottom: 70),
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: GridView.count(
            crossAxisCount: 2, // 2 элемента в строке
            crossAxisSpacing: 12,
            mainAxisSpacing: 12,
            childAspectRatio: 0.8, // ширина к высоте
            children: traits.map((trait) {
              return Container(
                padding: const EdgeInsets.all(8),
                decoration: BoxDecoration(
                  color: const Color(0xFF4B4B4B),
                  borderRadius: BorderRadius.circular(16),
                ),
                child: Column(crossAxisAlignment: CrossAxisAlignment.center,
                    children: [ Container(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 8, vertical: 4),
                    decoration: BoxDecoration(
                      color: const Color(0xFFFF8000),
                      borderRadius: BorderRadius.circular(8),
                    ),
                      child: trait == 'эмоциональная лабильность'
                          ? Text(
                        trait,
                        textAlign: TextAlign.center,
                        style: const TextStyle(
                          fontFamily: 'Gilroy-Medium',
                          fontSize: 14,
                          decoration: TextDecoration.none,
                          color: Colors.white,
                        ),
                      )
                          : FittedBox(
                        fit: BoxFit.scaleDown,
                        child: Text(
                          trait,
                          style: const TextStyle(
                            fontFamily: 'Gilroy-Medium',
                            fontSize: 14,
                            decoration: TextDecoration.none,
                            color: Colors.white,
                          ),
                        ),
                      ),
                  ),
                ]
                ),
              );
            }).toList(),
          ),
        ),
      );
  }
}
