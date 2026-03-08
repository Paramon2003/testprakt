import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class Interpretation extends StatefulWidget {
  final String authToken;

  const Interpretation({super.key, required this.authToken});

  @override
  State<Interpretation> createState() => _InterpretationState();
}

class _InterpretationState extends State<Interpretation> {
  String? analysisText;
  bool isLoading = true;

  @override
  void initState() {
    super.initState();
    fetchAnalysis();
  }

  Future<void> fetchAnalysis() async {
    try {
      final resultId = await fetchResultId();
      if (resultId != null) {
        final text = await fetchUiAnalysisText(resultId);
        if (mounted) {
          setState(() {
            analysisText = text;
            isLoading = false;
          });
        }
      } else {
        setState(() {
          analysisText = 'Результат не найден.';
          isLoading = false;
        });
      }
    } catch (e) {
      setState(() {
        analysisText = 'Ошибка: $e';
        isLoading = false;
      });
    }
  }

  Future<String?> fetchResultId() async {
    final url = Uri.parse('http://109.172.7.214:8080/api/v1/result');
    final response = await http.post(
      url,
      headers: {
        'Authorization': 'Bearer ${widget.authToken}',
        'Content-Type': 'application/json',
      },
    );

    if (response.statusCode == 200) {
      final data = jsonDecode(response.body);
      return data['id'];
    } else {
      print('Ошибка получения result_id: ${response.statusCode}');
      return null;
    }
  }

  Future<String?> fetchUiAnalysisText(String resultId) async {
    final url = Uri.parse('http://109.172.7.214:8080/api/v1/ui_analysis/$resultId');
    final response = await http.get(
      url,
      headers: {
        'Authorization': 'Bearer ${widget.authToken}',
        'Content-Type': 'application/json',
      },
    );

    if (response.statusCode == 200) {
      final data = jsonDecode(utf8.decode(response.bodyBytes));
      return data['text'];
    } else {
      print('Ошибка при получении анализа: ${response.statusCode}');
      return 'Не удалось получить интерпретацию.';
    }
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Stack(
        children: [
          Positioned(
            top: 100,
            left: 30,
            right: 30,
            child: Center(
              child: Container(
                padding: const EdgeInsets.all(16),
                decoration: BoxDecoration(
                  color: const Color(0xFF4B4B4B),
                  borderRadius: BorderRadius.circular(8),
                ),
                child: isLoading
                    ? const CircularProgressIndicator()
                    : Text(
                  analysisText ?? 'Нет данных',
                  textAlign: TextAlign.center,
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
        ],
      ),
    );
  }
}
