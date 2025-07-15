import 'package:flutter/material.dart';
import '../widgets/contentblocks.dart';

class Inst3 extends StatelessWidget {
  const Inst3({super.key});

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
                child: Text(
                  'Читайте утверждения',
                  style: TextStyle(
                    fontFamily: 'Gilroy',
                    fontSize: 24,
                    color: Colors.white,
                  ),
                )
            ),

            const Positioned(
              top: 150,
              left: 16,
              child: Text.rich(
                TextSpan(
                  children: [
                    TextSpan(
                      text: 'и ',
                      style: TextStyle(color: Colors.white, fontSize: 24, fontFamily: 'Gilroy'),
                    ),
                    TextSpan(
                      text: 'оценивайте',
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
                top: 180,
                left: 16,
                child: Text(
                  'верно оно для вас',
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
                  'или нет',
                  style: TextStyle(
                    fontFamily: 'Gilroy',
                    fontSize: 24,
                    color: Colors.white,
                  ),
                )
            ),

            const Positioned(
              top: 270,
              left: 16,
              child: Text.rich(
                TextSpan(
                  children: [
                    TextSpan(
                      text: 'верно ',
                      style: TextStyle(color: const Color(0xFFFF6C05), fontSize: 24, fontFamily: 'Gilroy'),
                    ),
                    TextSpan(
                      text: '- ',
                      style: TextStyle(color: Colors.white, fontSize: 24, fontFamily: 'Gilroy'),
                    ),
                  ],
                ),
              ),
            ),

            const Positioned(
              top: 350,
              left: 16,
              child: Text.rich(
                TextSpan(
                  children: [
                    TextSpan(
                      text: 'неверно ',
                      style: TextStyle(color: const Color(0xFFFF6C05), fontSize: 24, fontFamily: 'Gilroy'),
                    ),
                    TextSpan(
                      text: '- ',
                      style: TextStyle(color: Colors.white, fontSize: 24, fontFamily: 'Gilroy'),
                    ),
                  ],
                ),
              ),
            ),

            const Positioned(
              top: 260,
              left: 115,
              child: Image(
                image: AssetImage('assets/right.png'),
                width: 50,
                height: 50,
              ),
            ),

            const Positioned(
              top: 340,
              left: 140,
              child: Image(
                image: AssetImage('assets/wrong.png'),
                width: 50,
                height: 50,
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
                    Navigator.pushNamed(context, '/gender');
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
