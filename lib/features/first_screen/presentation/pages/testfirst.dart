import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:auto_size_text/auto_size_text.dart';
import '../widgets/test.dart';
import '../widgets/animatedfox.dart';

class Testfirst extends StatefulWidget {
  const Testfirst({super.key});

  @override
  State<Testfirst> createState() => _TestfirstState();
}

class _TestfirstState extends State<Testfirst> {
  String questionText = 'Загрузка...';
  bool isLoading = true;
  late String token;
  String? questionId;
  //int questionNumber = 1; // Начальный номер вопроса

  Future<void> fetchQuestion(String token) async {
    final response = await http.get(
      Uri.parse('http://109.172.7.214:8080/api/v1/question/random'),
      headers: {'Authorization': 'Bearer $token'},
    );

    if (response.statusCode == 200) {
      final data = jsonDecode(utf8.decode(response.bodyBytes));
      setState(() {
        questionText = data['text'];
        questionId = data['id']; // Сохраняем ID
        isLoading = false;
        //questionNumber++; // Увеличиваем номер вопроса после загрузки
      });
    } else {
      setState(() {
        questionText = 'Ошибка загрузки вопроса';
        isLoading = false;
      });
    }
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    token = ModalRoute.of(context)!.settings.arguments as String;
    fetchQuestion(token);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Test(
        token: token,
        questionId: questionId,
        questionNumber: 1,
        child: Center(
          child: isLoading
              ? const CircularProgressIndicator(
            color: Color(0xFFFF6C05),
          )
              : SizedBox(
            width: 300,
            child: AutoSizeText(
              questionText,
              textAlign: TextAlign.center,
              style: const TextStyle(
                fontSize: 18,
                fontFamily: 'Gilroy',
                color: Colors.black,
              ),
              minFontSize: 12,
              maxLines: 4,
              overflow: TextOverflow.ellipsis,
            ),
          ),
        ),
        fox: const AnimatedFoxContainer(),
      ),
    );
  }
}
