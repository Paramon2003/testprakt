import 'package:flutter/material.dart';
import 'package:testprakt/features/first_screen/presentation/widgets/additional.dart';
import 'package:testprakt/features/first_screen/presentation/widgets/basic.dart';
import 'package:testprakt/features/first_screen/presentation/widgets/resultsbox.dart';

import '../widgets/interpretation.dart';

class Results extends StatefulWidget {
  const Results({super.key});

  @override
  State<Results> createState() => _ResultsState();
}

class _ResultsState extends State<Results> {
  int selectedIndex = 0;

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        const Positioned.fill(
          child: Image(
            image: AssetImage('assets/fon1.png'),
            fit: BoxFit.cover,
          ),
        ),
        Positioned.fill(
          child: Container(
            color: Colors.white.withOpacity(0.3),
          ),
        ),
        Positioned.fill(
          child: Center(
            child: Container(
              width: 320,
              height: 600,
              decoration: BoxDecoration(
                color: const Color(0xFFFFAF76),
                borderRadius: BorderRadius.circular(24),
              ),
              child: Stack(
                children: [
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
                        child: const Center(
                          child: Text(
                            'РЕЗУЛЬТАТЫ',
                            style: TextStyle(
                              fontSize: 24,
                              decoration: TextDecoration.none,
                              fontFamily: 'Gilroy',
                              fontWeight: FontWeight.bold,
                              color: Colors.black,
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),

                  ResultsBox(
                    selectedIndex: selectedIndex,
                    onOptionSelected: (index) {
                      setState(() {
                        selectedIndex = index;
                      });
                    },
                  ),

                  if (selectedIndex == 0) Basic(),
                  if (selectedIndex == 1) Additional(),
                  if (selectedIndex == 2) Interpretation(),

                  Positioned(
                    bottom: 20,
                    left: 200,
                    right: 0,
                    child: Center(
                      child: ElevatedButton(
                        onPressed: () {
                          Navigator.pushNamed(context, '/share');
                        },
                        style: ElevatedButton.styleFrom(
                          backgroundColor: const Color(0xFFFF6C05),
                          shape: const CircleBorder(),
                          padding: const EdgeInsets.all(20),
                        ),
                        child: const Padding(
                          padding: EdgeInsets.only(top: 4),
                          child: Text(
                            '➜',
                            style: TextStyle(
                              fontFamily: 'Gilroy',
                              fontSize: 24,
                              color: Colors.black,
                            ),
                          ),
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
