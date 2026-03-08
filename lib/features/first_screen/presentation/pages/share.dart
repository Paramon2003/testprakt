import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class Share extends StatefulWidget {
  final String authToken;

  const Share({super.key, required this.authToken});

  @override
  State<Share> createState() => _ShareState();
}

class _ShareState extends State<Share> {
  String? resultUrl;
  Uint8List? qrImageBytes;
  bool isLoading = true;

  @override
  void initState() {
    super.initState();
    loadQRData();
  }

  Future<void> loadQRData() async {
    try {
      // 1. Получаем result_id
      final resultId = await fetchResultId();
      if (resultId == null) throw Exception("Не удалось получить result_id");

      // 2. Формируем URL на страницу результатов
      final url = 'http://109.172.7.214:8080/results/$resultId';
      setState(() => resultUrl = url);

      // 3. Получаем QR-код по URL
      final qrBytes = await fetchQrCodeImage(url);
      setState(() {
        qrImageBytes = qrBytes;
        isLoading = false;
      });
    } catch (e) {
      print('Ошибка: $e');
      setState(() => isLoading = false);
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
    }
    return null;
  }

  Future<Uint8List> fetchQrCodeImage(String url) async {
    final qrUrl = Uri.parse(
      'http://109.172.7.214:8080/api/v1/qr_code/$url?size=270&color=%23FF6C05&bg_color=%23FFD5B8',
    );
    final response = await http.get(qrUrl);
    if (response.statusCode == 200) {
      return response.bodyBytes;
    } else {
      throw Exception("QR-код не загружен");
    }
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        // Фон
        const Positioned.fill(
          child: Image(
            image: AssetImage('assets/fon1.png'),
            fit: BoxFit.cover,
          ),
        ),

        // Затемнение
        Positioned.fill(
          child: Container(
            color: Colors.white.withOpacity(0.3),
          ),
        ),

        // Центральный контейнер
        Positioned.fill(
          child: Center(
            child: Container(
              width: 320,
              height: 600,
              decoration: BoxDecoration(
                color: const Color(0xFF4B4B4B),
                borderRadius: BorderRadius.circular(24),
              ),
              child: Stack(
                children: [
                  Positioned(
                    top: 50,
                    left: 25,
                    child: isLoading
                        ? const SizedBox(
                      width: 270,
                      height: 270,
                      child: Center(
                        child: CircularProgressIndicator(color: Colors.white),
                      ),
                    )
                        : qrImageBytes != null
                        ? Image.memory(
                      qrImageBytes!,
                      width: 270,
                      height: 270,
                    )
                        : const Text("Ошибка загрузки QR"),
                  ),
                  Positioned(
                    top: 370,
                    left: 20,
                    right: 20,
                    child: Container(
                      padding: const EdgeInsets.all(12),
                      decoration: BoxDecoration(
                        color: const Color(0xFFFFAF76),
                        border: Border.all(
                          color: const Color(0xFFFF6C05),
                          width: 2,
                        ),
                        borderRadius: BorderRadius.circular(16),
                      ),
                      child: Text(
                        resultUrl ?? 'Ссылка не найдена',
                        textAlign: TextAlign.left,
                        style: const TextStyle(
                          color: Colors.black,
                          fontSize: 14,
                          decoration: TextDecoration.none,
                          fontFamily: 'Gilroy-Medium',
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ],
    );
  }
}
