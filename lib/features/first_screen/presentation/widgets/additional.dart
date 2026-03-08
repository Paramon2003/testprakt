import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'dart:math';

class Additional extends StatefulWidget {
  final String authToken;

  const Additional({super.key, required this.authToken});

  @override
  State<Additional> createState() => _AdditionalState();
}

class _AdditionalState extends State<Additional> {
  List<dynamic> categoryResults = [];
  bool isLoading = true;

  @override
  void initState() {
    super.initState();
    loadResults();
  }

  Future<void> loadResults() async {
    try {
      final resultId = await fetchResultId();
      if (resultId != null) {
        await fetchCategoryResults(resultId);
      } else {
        print("Нет результата у пользователя.");
      }
    } catch (e) {
      print("Ошибка при получении данных: $e");
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
    } else if (response.statusCode == 404) {
      print('Результат не найден у пользователя');
      return null;
    } else {
      print('Ошибка при получении result_id: ${response.statusCode}');
      return null;
    }
  }

  Future<void> fetchCategoryResults(String resultId) async {
    final url = Uri.parse(
        'http://109.172.7.214:8080/api/v1/category_results/other/$resultId');
    final response = await http.get(
      url,
      headers: {
        'Authorization': 'Bearer ${widget.authToken}',
        'Content-Type': 'application/json',
      },
    );

    if (response.statusCode == 200) {
      final jsonData = jsonDecode(utf8.decode(response.bodyBytes));
      if (mounted) {
        setState(() {
          categoryResults = jsonData['category_results'];
          isLoading = false;
        });
      }
    } else {
      print('Ошибка при получении категорий: ${response.statusCode}');
      setState(() => isLoading = false);
    }
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      minimum: const EdgeInsets.only(top: 150, bottom: 70),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: isLoading
            ? const Center(child: CircularProgressIndicator())
            : GridView.count(
          crossAxisCount: 2,
          crossAxisSpacing: 12,
          mainAxisSpacing: 12,
          childAspectRatio: 0.8,
          children: categoryResults.map((item) {
            final trait = item['category_name'];
            final score = item['score'];
            final max = item['max_score'];

            return Container(
              padding: const EdgeInsets.all(8),
              decoration: BoxDecoration(
                color: const Color(0xFF4B4B4B),
                borderRadius: BorderRadius.circular(16),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Container(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 8, vertical: 4),
                    decoration: BoxDecoration(
                      color: const Color(0xFFFF8000),
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: FittedBox(
                      fit: BoxFit.scaleDown,
                      child: Text(
                        trait,
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
                  const SizedBox(height: 12),
                  SizedBox(
                    height: 100,
                    width: 100,
                    child: Stack(
                      alignment: Alignment.center,
                      children: [
                        CustomPaint(
                          size: const Size(100, 100),
                          painter: CircularProgressPainter(
                            percentage: (score / max) * 100,
                            backgroundColor: const Color(0xFFFF6C05),
                            gradient: const LinearGradient(
                              colors: [
                                Color(0xFFFF8000),
                                Color(0xFF663019)
                              ],
                            ),
                          ),
                        ),
                        Text(
                          '$score',
                          style: const TextStyle(
                            fontFamily: 'Gilroy-Medium',
                            fontSize: 18,
                            decoration: TextDecoration.none,
                            color: Colors.white,
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            );
          }).toList(),
        ),
      ),
    );
  }
}

// === Кастомный прогресс ===

class CircularProgressPainter extends CustomPainter {
  final double percentage;
  final Color backgroundColor;
  final Gradient gradient;

  CircularProgressPainter({
    required this.percentage,
    required this.backgroundColor,
    required this.gradient,
  });

  @override
  void paint(Canvas canvas, Size size) {
    final strokeWidth = 5.0;
    final radius = (size.width - strokeWidth) / 2;
    final center = Offset(size.width / 2, size.height / 2);

    final backgroundPaint = Paint()
      ..color = backgroundColor
      ..style = PaintingStyle.stroke
      ..strokeWidth = strokeWidth;
    canvas.drawCircle(center, radius, backgroundPaint);

    final rect = Rect.fromCircle(center: center, radius: radius);
    final gradientPaint = Paint()
      ..shader = gradient.createShader(rect)
      ..style = PaintingStyle.stroke
      ..strokeCap = StrokeCap.round
      ..strokeWidth = 9;

    final sweepAngle = 2 * pi * (percentage / 100);
    canvas.drawArc(
      Rect.fromCircle(center: center, radius: radius),
      -pi / 2,
      sweepAngle,
      false,
      gradientPaint,
    );
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) => true;
}
