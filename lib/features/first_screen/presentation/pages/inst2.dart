import 'package:flutter/material.dart';
import '../widgets/contentblocks.dart';

class Inst2 extends StatelessWidget {
  const Inst2({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BackgroundLayout(
        child: Stack(
          children: [
            const Positioned(
              top: 50,
              left: 0,
              right: 0,
              child: Center(
                child: Text(
                  'ИНСТРУКЦИЯ',
                  style: TextStyle(
                    fontSize: 24,
                    fontFamily: 'Gilroy', fontWeight: FontWeight.bold,
                    color: Colors.black,
                  ),
                ),
              ),
            ),

            const Positioned(
              top: 120,
              left: 16,
              child: Text.rich(
                TextSpan(
                  children: [
                    TextSpan(
                      text: 'Отвечайте ',
                      style: TextStyle(color: Colors.white, fontSize: 24, fontFamily: 'Gilroy'),
                    ),
                    TextSpan(
                      text: 'честно',
                      style: TextStyle(color: const Color(0xFFFF6C05), fontSize: 24, fontFamily: 'Gilroy'),
                    ),
                    TextSpan(
                      text: ',',
                      style: TextStyle(color: Colors.white, fontSize: 24, fontFamily: 'Gilroy'),
                    ),
                  ],
                ),
              ),
            ),

            const Positioned(
                top: 160,
                left: 16,
                child: Text(
                  'ваши ответы',
                  style: TextStyle(
                    fontFamily: 'Gilroy',
                    fontSize: 24,
                    color: Colors.white,
                  ),
                )
            ),

            const Positioned(
              top: 200,
              left: 16,
              child: Text.rich(
                TextSpan(
                  children: [
                    TextSpan(
                      text: 'никто ',
                      style: TextStyle(color: Colors.white, fontSize: 24, fontFamily: 'Gilroy'),
                    ),
                    TextSpan(
                      text: 'не увидит',
                      style: TextStyle(color: const Color(0xFFFF6C05), fontSize: 24, fontFamily: 'Gilroy'),
                    ),
                  ],
                ),
              ),
            ),

            const Positioned(
              top: 250,
              right: 30,
              child: Image(
                image: AssetImage('assets/inst2.png'),
                width: 300,
                height: 300,
              ),
            ),

            // Кнопка
            Positioned(
              bottom: 20,
              left: 200,
              right: 0,
              child: Center(
                child: ElevatedButton(
                  onPressed: () {
                    Navigator.pushNamed(context, '/inst3');
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color(0xFFFF6C05),
                    shape: const CircleBorder(),
                    padding: const EdgeInsets.all(20),
                  ),
                  child: const Text('➜',
                    style: TextStyle(
                      fontFamily: 'Gilroy',
                      fontSize: 24,
                      color: Colors.black,
                    ),),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
