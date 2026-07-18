// lib/core/services/groq_service.dart
import 'package:http/http.dart' as http;
import 'dart:convert';
import '../constants/api_keys.dart';

class GroqService {
  static const String _apiUrl = 'https://api.groq.com/openai/v1/chat/completions';
  static const String _model = 'openai/gpt-oss-20b';
  static const String _modelPro = 'openai/gpt-oss-120b';
  /// Ask LLaMA a question through Groq API
  static Future<String> askTutor(String question, {bool isPro = false}) async {
    try {
      final response = await http.post(
        Uri.parse(_apiUrl),
        headers: {
          'Authorization': 'Bearer ${ApiKeys.groqApiKey}',
          'Content-Type': 'application/json',
        },
        body: jsonEncode({
          'model': isPro ? _modelPro : _model,
          'messages': [
            {
              'role': 'system',
              'content': '''You are an expert educational tutor for secondary and university students. 
Your role is to:
- Explain concepts clearly and simply
- Provide step-by-step solutions
- Use examples and analogies
- Adapt to the student's level
- Encourage deeper understanding
- Be encouraging and supportive

Keep responses concise but comprehensive (2-3 paragraphs max).'''
            },
            {
              'role': 'user',
              'content': question
            }
          ],
          'temperature': 0.7,
          'max_tokens': 1024,
        }),
      );

      if (response.statusCode == 200) {
        final jsonResponse = jsonDecode(response.body);
        final answer = jsonResponse['choices'][0]['message']['content'] as String;
        return answer;
      } else if (response.statusCode == 401) {
        throw Exception('Invalid Groq API key. Please check your API key in lib/core/constants/api_keys.dart');
      } else if (response.statusCode == 429) {
        throw Exception('Rate limit exceeded. Please wait a moment and try again.');
      } else {
        throw Exception('Groq API error: ${response.statusCode} - ${response.body}');
      }
    } catch (e) {
      throw Exception('Error calling Groq API: $e');
    }
  }

  /// Ask LLaMA multiple follow-up questions (for chat history context)
  static Future<String> askTutorWithHistory(
  String question,
  List<Map<String, String>> history, {
  bool isPro = false,
}) async {
    try {
      final messages = [
        {
          'role': 'system',
          'content': '''You are an expert educational tutor for secondary and university students. 
Your role is to:
- Explain concepts clearly and simply
- Provide step-by-step solutions
- Use examples and analogies
- Adapt to the student's level
- Encourage deeper understanding
- Be encouraging and supportive

Keep responses concise but comprehensive (2-3 paragraphs max).'''
        },
        ...history,
        {
          'role': 'user',
          'content': question
        }
      ];

      final response = await http.post(
        Uri.parse(_apiUrl),
        headers: {
          'Authorization': 'Bearer ${ApiKeys.groqApiKey}',
          'Content-Type': 'application/json',
        },
        body: jsonEncode({
          'model': isPro ? _modelPro : _model,
          'messages': messages,
          'temperature': 0.7,
          'max_tokens': 1024,
        }),
      );

      if (response.statusCode == 200) {
        final jsonResponse = jsonDecode(response.body);
        final answer = jsonResponse['choices'][0]['message']['content'] as String;
        return answer;
      } else {
        throw Exception('Failed to get response: ${response.statusCode}');
      }
    } catch (e) {
      throw Exception('Error: $e');
    }
  }
}