import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import '../widgets/test.dart';
import 'package:auto_size_text/auto_size_text.dart';

class TestNextPages extends StatefulWidget {
  final bool swipedLeft;
  final bool swipedUp;
  final int questionNumber;

  const TestNextPages({super.key, required this.swipedLeft, required this.swipedUp, required this.questionNumber});

  @override
  State<TestNextPages> createState() => _TestNextPagesState();
}

class _TestNextPagesState extends State<TestNextPages> {
  String questionText = 'Загрузка...';
  bool isLoading = true;
  late String token;
  String? questionId;

  Future<void> fetchNextQuestion(String token) async {
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
        //questionNumber++;
      });
    } else {
      if (mounted) {
        Navigator.pushReplacementNamed(context, '/testfinish');
      }
    }
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    token = ModalRoute.of(context)!.settings.arguments as String;
    fetchNextQuestion(token);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Test(
        token: token,
        questionId: questionId,
        questionNumber: widget.questionNumber,
        //questionNumber: questionNumber,
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
        fox: Stack(
          children: const [
            Positioned(
              top: 250,
              child: Center(
              child: Image(
                image: AssetImage('assets/test2.png'),
                width: 300,
                height: 300,
              ),
            ),
            ),
          ],
        ),
      ),
    );
  }
}
