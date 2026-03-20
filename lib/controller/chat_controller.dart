import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:flutter_dotenv/flutter_dotenv.dart';

class ChatController extends ChangeNotifier {
  static final ChatController _instance = ChatController._internal();
  factory ChatController() => _instance;

  ChatController._internal() {
    messages.add({
      'role': 'assistant',
      'content': 'Halo! Apa yang ingin kamu ketahui tentang Bangka Belitung?',
    });
  }

  final List<Map<String, String>> messages = [];
  bool isLoading = false;

  final _apiKey = dotenv.env['GEMINI_KEY'];

  Future<void> sendMessage(String text) async {
    if (text.isEmpty) return;

    messages.add({'role': 'user', 'content': text});

    if (!text.toLowerCase().contains("bangka") &&
        !text.toLowerCase().contains("belitung")) {
      messages.add({
        'role': 'assistant',
        'content':
            'Maaf, saya hanya menjawab tentang Bangka Belitung.',
      });
      notifyListeners();
      return;
    }

    isLoading = true;
    notifyListeners();

    try {
      final response = await http.post(
        Uri.parse(
          'https://generativelanguage.googleapis.com/v1beta/models/gemini-2.5-flash:generateContent?key=$_apiKey',
        ),
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode({
          'contents': [
            {
              "role": "user",
              "parts": [
                {
                  "text": "User: $text",
                },
              ],
            },
          ],
        }),
      );

      final data = jsonDecode(response.body);
      final candidates = data["candidates"];

      if (candidates == null || candidates.isEmpty) {
        messages.add({
          'role': 'assistant',
          'content': 'Tidak ada jawaban.',
        });
      } else {
        final reply = candidates[0]["content"]["parts"][0]["text"] ?? "";
        messages.add({'role': 'assistant', 'content': reply});
      }
    } catch (e) {
      messages.add({'role': 'assistant', 'content': 'Error: $e'});
    }

    isLoading = false;
    notifyListeners();
  }
}