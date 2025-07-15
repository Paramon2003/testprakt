import 'package:flutter/material.dart';

class Interpretation extends StatelessWidget {
  Interpretation({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Stack(
        children: [Positioned(
        top: 100,
          child: Center(
            child: Container(
              width: 300,
              height: 200,
              decoration: BoxDecoration(
                color: const Color(0xFF4B4B4B),
                borderRadius: BorderRadius.circular(8),
              ),
              child: Text(
                  "trait",
                  style: const TextStyle(
                    fontFamily: 'Gilroy-Medium',
                    fontSize: 14,
                    decoration: TextDecoration.none,
                    color: Colors.white,
                  ),
                ),
              ),
            ),
          )
          ]
      )
    );
  }
}
