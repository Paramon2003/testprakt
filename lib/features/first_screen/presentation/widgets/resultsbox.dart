import 'package:flutter/material.dart';

class ResultsBox extends StatelessWidget {
  final int selectedIndex;
  final void Function(int) onOptionSelected;

  const ResultsBox({
    super.key,
    required this.selectedIndex,
    required this.onOptionSelected,
  });

  final List<String> options = const [
    'основные',
    'дополнительные',
    'интерпритация',
  ];

  @override
  Widget build(BuildContext context) {
    return Positioned(
      top: 120,
      left: 0,
      right: 0,
      child: SingleChildScrollView(
        scrollDirection: Axis.horizontal,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: List.generate(options.length, (index) {
            final isSelected = selectedIndex == index;
            return GestureDetector(
              onTap: () => onOptionSelected(index),
              child: Container(
                margin: const EdgeInsets.symmetric(horizontal: 6),
                padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 12),
                decoration: BoxDecoration(
                  color: isSelected ? const Color(0xFF4B4B4B) : const Color(0xFFFFAF76),
                  borderRadius: BorderRadius.circular(12),
                ),
                alignment: Alignment.center,
                child: Text(
                  options[index],
                  style: TextStyle(
                    fontSize: 14,
                    decoration: TextDecoration.none,
                    fontFamily: 'Gilroy-Medium',
                    color: isSelected ? Colors.white : const Color(0xFFFF6C05),
                  ),
                ),
              ),
            );
          }),
        ),
      ),
    );
  }
}
