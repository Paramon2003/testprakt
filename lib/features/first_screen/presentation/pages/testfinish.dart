import 'package:flutter/material.dart';
import 'package:testprakt/features/first_screen/presentation/pages/results.dart';
import '../widgets/contentblocks.dart';

class TestFinish extends StatelessWidget {
  final String authToken;

  const TestFinish({super.key, required this.authToken});

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
                  'КОНЕЦ!',
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
                      text: 'Тест ',
                      style: TextStyle(color: Colors.white, fontSize: 24, fontFamily: 'Gilroy'),
                    ),
                    TextSpan(
                      text: 'завершен',
                      style: TextStyle(color: const Color(0xFFFF6C05), fontSize: 24, fontFamily: 'Gilroy'),
                    ),
                    TextSpan(
                      text: '!',
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
                  'хочешь узнать,',
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
                  'что мы нашли?',
                  style: TextStyle(
                    fontFamily: 'Gilroy',
                    fontSize: 24,
                    color: Colors.white,
                  ),
                )
            ),

            const Positioned(
              top: 250,
              right: 30,
              child: Image(
                image: AssetImage('assets/finish.png'),
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
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => Results(authToken: authToken)),
                    );
                    //Navigator.pushNamed(context, '/results');
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
