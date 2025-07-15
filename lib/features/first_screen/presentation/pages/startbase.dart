import 'package:flutter/material.dart';
import '../widgets/contentblocks.dart';

class Start extends StatelessWidget {
  const Start({super.key});

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
                  'ЗДРАВСТВУЙТЕ!',
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
                      text: 'я ',
                      style: TextStyle(color: Colors.white, fontSize: 24, fontFamily: 'Gilroy'),
                    ),
                    TextSpan(
                      text: 'Фоксик',
                      style: TextStyle(color: const Color(0xFFFF6C05), fontSize: 24, fontFamily: 'Gilroy'),
                    ),
                    TextSpan(
                      text: ' -',
                      style: TextStyle(color: Colors.white, fontSize: 24, fontFamily: 'Gilroy'),
                    ),
                  ],
                ),
              ),
            ),

            const Positioned(
              top: 150,
              left: 16,
              child: Text(
              'ваш проводник',
              style: TextStyle(
                fontFamily: 'Gilroy',
                fontSize: 24,
                color: Colors.white,
                ),
              )
            ),

            const Positioned(
                top: 180,
                left: 16,
                child: Text(
                  'по тесту',
                  style: TextStyle(
                    fontFamily: 'Gilroy',
                    fontSize: 24,
                    color: Colors.white,
                  ),
                )
            ),

            const Positioned(
                top: 210,
                left: 16,
                child: Text(
                  'давайте начнем!',
                  style: TextStyle(
                    fontFamily: 'Gilroy',
                    fontSize: 24,
                    color: const Color(0xFFFF6C05),
                  ),
                )
            ),

            const Positioned(
              top: 250,
              right: 5,
              child: Image(
                image: AssetImage('assets/start.png'),
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
                    Navigator.pushNamed(context, '/inst1');
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
    );
  }
}
