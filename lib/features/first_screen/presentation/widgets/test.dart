import 'package:flutter/material.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;
import '../pages/testnext.dart';

class Test extends StatelessWidget {
  final Widget child;
  final Widget fox;
  final String token;
  final String? questionId;
  final int questionNumber;
  final bool isLoading;

  const Test({
    super.key,
    required this.child,
    required this.fox,
    required this.token,
    this.questionId,
    required this.questionNumber,
    required this.isLoading,
  });


  Future<void> sendAnswer(String token, String questionId, String option) async {
    final response = await http.post(
      Uri.parse('http://109.172.7.214:8080/api/v1/answer'),
      headers: {
        'Authorization': 'Bearer $token',
        'Content-Type': 'application/json',
      },
      body: jsonEncode({
        'question': questionId,
        'option': option,
      }),
    );

    if (response.statusCode == 200) {
      print("Ответ отправлен");
    } else {
      print("Ошибка отправки: ${response.statusCode}");
    }
  }

  void navigateWithSwipe(BuildContext context, bool swipedLeft, String token) async {
    if (isLoading || questionId == null) {
      return;
    }
    if (questionId != null) {
      // Отправляем ответ в зависимости от свайпа
      await sendAnswer(token, questionId!, swipedLeft ? 'no' : 'yes'); // 'no' для влево, 'yes' для вправо
    }

    Navigator.push(
      context,
      PageRouteBuilder(
        pageBuilder: (_, __, ___) => TestNextPages(swipedLeft: swipedLeft, swipedUp: false, questionNumber: questionNumber + 1,),
        settings: RouteSettings(arguments: token), // передаём токен
        transitionsBuilder: (context, animation, secondaryAnimation, child) {
          final offsetAnimation = Tween<Offset>(
            begin: Offset(swipedLeft ? 1.0 : -1.0, 0),
            end: Offset.zero,
          ).animate(CurvedAnimation(parent: animation, curve: Curves.easeInOut));
          return SlideTransition(position: offsetAnimation, child: child);
        },
        transitionDuration: const Duration(milliseconds: 400),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onHorizontalDragEnd: (details) {
        if (isLoading) return;
        if (details.primaryVelocity == null) return;
        if (details.primaryVelocity! < -100) {
          // Свайп влево
          navigateWithSwipe(context, true, token);
        } else if (details.primaryVelocity! > 100) {
          // Свайп вправо
          navigateWithSwipe(context, false, token);
        }
      },
      child: Stack(
        children: [
          const Positioned.fill(
            child: Image(
              image: AssetImage('assets/fon2.png'),
              fit: BoxFit.cover,
            ),
          ),

          Positioned(
            top: 25,
            left: 220,
            right: 0,
            child: Center(
              child: Container(
                width: 100,
                height: 40,
                decoration: BoxDecoration(
                  color: const Color(0xFF2D2D2D),
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Center(
                  child: Text(
                    '$questionNumber/566',
                    style: const TextStyle(
                      color: const Color(0xFFFF6C05),
                      fontFamily: 'Gilroy',
                      fontSize: 16,
                    ),
                  ),
                ),
              ),
            ),
          ),
          Positioned.fill(
            child: Align(
              alignment: Alignment.topCenter,
              child: Padding(
                padding: const EdgeInsets.only(top: 76),
                child: Container(
                  width: 330,
                  height: 120,
                  decoration: BoxDecoration(
                    color: const Color(0xFFFF954B),
                    borderRadius: BorderRadius.circular(24),
                  ),
                  child: child,
                ),
              ),
            ),
          ),
          Positioned.fill(
            top: 75,
            child: Center(child: fox),
          ),
          // Левая кнопка "да" (свайп вправо)
          Positioned(
            bottom: 40,
            left: 0,
            right: 250,
            child: Center(
              child: ElevatedButton(
                onPressed: () async {
                  if (isLoading || questionId == null) return;
                  if (questionId != null) {
                    await sendAnswer(token, questionId!, 'yes'); // Отправляем ответ
                  }
                  navigateWithSwipe(context, false, token); // вправо
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0xFFFF6C05),
                  shape: const CircleBorder(),
                  padding: const EdgeInsets.all(20),
                ),
                child: Image.asset('assets/right.png', width: 40, height: 40),
              ),
            ),
          ),
          // Кнопка "не знаю"
          Positioned(
            bottom: 50,
            left: 0,
            right: 0,
            child: Center(
              child: ElevatedButton(
                onPressed: () async {
                  if (isLoading || questionId == null) return;
                  if (questionId != null) {

                    await sendAnswer(token, questionId!, 'idk'); // Отправляем ответ
                  }

                  // Переход с анимацией свайпа вверх
                  Navigator.push(
                    context,
                    PageRouteBuilder(
                      pageBuilder: (_, __, ___) => TestNextPages(swipedLeft: false, swipedUp: true, questionNumber: questionNumber + 1,),
                      settings: RouteSettings(arguments: token),
                      transitionsBuilder: (context, animation, secondaryAnimation, child) {
                        final offsetAnimation = Tween<Offset>(
                          begin: Offset(0, 1), // Начало с нижней части экрана
                          end: Offset.zero, // Конечная позиция — центр экрана
                        ).animate(CurvedAnimation(parent: animation, curve: Curves.easeInOut));
                        return SlideTransition(position: offsetAnimation, child: child);
                      },
                      transitionDuration: const Duration(milliseconds: 400),
                    ),
                  );
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0xFF2D2D2D),
                  padding: const EdgeInsets.all(15),
                ),
                child: const Text(
                  'не знаю',
                  style: TextStyle(
                    fontFamily: 'Gilroy',
                    fontSize: 20,
                    color: Colors.white,
                  ),
                ),
              ),
            ),
          ),
          // Правая кнопка "нет" (свайп влево)
          Positioned(
            bottom: 40,
            left: 250,
            right: 0,
            child: Center(
              child: ElevatedButton(
                onPressed: () async {
                  if (isLoading || questionId == null) return;
                  if (questionId != null) {

                    await sendAnswer(token, questionId!, 'no'); // Отправляем ответ
                  }
                  navigateWithSwipe(context, true, token); // влево

                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0xFFFF6C05),
                  shape: const CircleBorder(),
                  padding: const EdgeInsets.all(20),
                ),
                child: Image.asset('assets/wrong.png', width: 40, height: 40),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
