import 'package:flutter/material.dart';

class SelectableBox extends StatefulWidget {
  final Function(bool isMale) onGenderSelected;

  const SelectableBox({super.key, required this.onGenderSelected});

  @override
  State<SelectableBox> createState() => _SelectableBoxState();
}

class _SelectableBoxState extends State<SelectableBox> {
  int? selectedIndex;

  final List<String> options = ['женский', 'мужской'];

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: List.generate(options.length, (index) {
        final isSelected = selectedIndex == index;
        return GestureDetector(
          onTap: () {
            setState(() {
              selectedIndex = index;
            });
            widget.onGenderSelected(index == 1); // true = male
          },
          child: Container(
            margin: const EdgeInsets.symmetric(vertical: 8),
            width: 300,
            padding: const EdgeInsets.symmetric(vertical: 5),
            decoration: BoxDecoration(
              color: const Color(0xFFFF954B),
              borderRadius: BorderRadius.circular(12),
              border: Border.all(
                color: isSelected ? const Color(0xFFFF7D22) : Colors.transparent,
                width: 3,
              ),
            ),
            alignment: Alignment.center,
            child: Text(
              options[index],
              style: const TextStyle(
                fontSize: 20,
                fontFamily: 'Gilroy',
                decoration: TextDecoration.none,
                color: Color(0xFF2D2D2D),
              ),
            ),
          ),
        );
      }),
    );
  }
}
