// lib/services/chatbot_service.dart

import 'dart:convert';
import 'package:http/http.dart' as http;

class ChatMessage {
  final String role;
  final String content;
  final DateTime timestamp;

  ChatMessage({required this.role, required this.content, DateTime? timestamp})
      : timestamp = timestamp ?? DateTime.now();

  Map<String, dynamic> toJson() => {
        'role': role,
        'content': content,
        'timestamp': timestamp.toIso8601String(),
      };

  factory ChatMessage.fromJson(Map<String, dynamic> json) {
    return ChatMessage(
      role: json['role'],
      content: json['content'],
      timestamp: DateTime.parse(json['timestamp']),
    );
  }
}

class ChatbotService {
  // 🔑 Gemini API Key
  static const String _apiKey = 'AIzaSyBQgbl92wdeTKIuQVCKtuktAQryETxj6dI';

  // ✅ NEW valid Gemini endpoint
  static const String _apiUrl =
      'https://generativelanguage.googleapis.com/v1beta/models/gemini-2.0-flash:generateContent';

  // 🌍 System prompt
  static const String _systemPrompt = '''You are an expert tourist guide ... (your prompt)''';

  Future<String> sendMessage(
    String userMessage,
    List<ChatMessage> conversationHistory,
  ) async {
    try {
      // Build conversation 
      String conversationContext = _systemPrompt + '\n\n';

      int startIndex = conversationHistory.length > 5
          ? conversationHistory.length - 5
          : 0;

      for (int i = startIndex; i < conversationHistory.length; i++) {
        final msg = conversationHistory[i];
        conversationContext +=
            '${msg.role == 'user' ? 'User' : 'Assistant'}: ${msg.content}\n';
      }

      conversationContext += 'User: $userMessage\nAssistant:';

      // Prepare request
      final response = await http.post(
        Uri.parse('$_apiUrl?key=$_apiKey'),
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode({
          'contents': [
            {
              'parts': [
                {'text': conversationContext},
              ],
            },
          ],
          'generationConfig': {
            'temperature': 0.7,
            'topK': 40,
            'topP': 0.95,
            'maxOutputTokens': 1024,
          }
        }),
      );

      if (response.statusCode == 200) {
        final data = jsonDecode(utf8.decode(response.bodyBytes));

        if (data['candidates'] != null &&
            data['candidates'].isNotEmpty &&
            data['candidates'][0]['content'] != null) {
          return data['candidates'][0]['content']['parts'][0]['text'];
        }

        throw Exception('No text generated');
      } else {
        final err = jsonDecode(response.body);
        throw Exception(err['error']['message']);
      }
    } catch (e) {
      throw Exception('Failed to get response: $e');
    }
  }
}
