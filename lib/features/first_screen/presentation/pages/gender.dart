import 'package:flutter/material.dart';
import '../widgets/selectablebox.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;

class Gender extends StatefulWidget {
  const Gender({super.key});

  @override
  State<Gender> createState() => _GenderState();
}

class _GenderState extends State<Gender> {
  bool? isMale;

  Future<void> _submitGender() async {
    if (isMale == null) return;

    final response = await http.post(
      Uri.parse('http://109.172.7.214:8080/api/v1/test_taker'),
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode({'is_male': isMale}),
    );

    if (response.statusCode == 200) {
      final data = jsonDecode(response.body);
      final token = data['access_token'];

      Navigator.pushNamed(context, '/test1', arguments: token);
    } else {
      print('Ошибка при отправке пола: ${response.body}');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        const Positioned.fill(
          child: Image(
            image: AssetImage('assets/fon2.png'),
            fit: BoxFit.cover,
          ),
        ),
        Positioned(
          top: 56,
          left: 16,
          right: 16,
          child: Center(
            child: Container(
              width: 300,
              height: 60,
              decoration: BoxDecoration(
                color: const Color(0xFFFF954B),
                borderRadius: BorderRadius.circular(16),
              ),
              child: const Center(
                child: Text(
                  'выберите свой пол',
                  style: TextStyle(
                    fontFamily: 'Gilroy',
                    fontSize: 24,
                    decoration: TextDecoration.none,
                    color: Color(0xFF2D2D2D),
                  ),
                ),
              ),
            ),
          ),
        ),
        Center(
          child: Container(
            width: 350,
            height: 160,
            decoration: BoxDecoration(
              color: const Color(0xFFFFAF76),
              borderRadius: BorderRadius.circular(16),
            ),
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: SelectableBox(
                onGenderSelected: (bool selectedIsMale) {
                  setState(() {
                    isMale = selectedIsMale;
                  });
                },
              ),
            ),
          ),
        ),
        Positioned(
          bottom: 120,
          left: 0,
          right: 0,
          child: Center(
            child: ElevatedButton(
              onPressed: _submitGender,
              style: ElevatedButton.styleFrom(
                backgroundColor: const Color(0xFFFF8000),
                padding: const EdgeInsets.all(15),
              ),
              child: const Text(
                'продолжить',
                style: TextStyle(
                  fontFamily: 'Gilroy',
                  fontSize: 24,
                  color: Colors.black,
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }
}
