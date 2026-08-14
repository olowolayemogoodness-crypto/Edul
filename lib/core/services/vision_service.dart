// lib/core/services/vision_service.dart
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'dart:io';
import '../constants/api_keys.dart';

class VisionService {
  static const String _apiUrl = 'https://api.groq.com/openai/v1/chat/completions';
  // Was 'llama-3.1-70b-versatile' -- not a currently valid Groq model id
  // at all (Groq deprecated its Llama vision route entirely and
  // explicitly recommends 'the multimodal qwen/qwen3.6-27b' as the
  // replacement). This call was very likely failing outright before
  // this fix, not just using a stale-but-working model.
  static const String _model = 'qwen/qwen3.6-27b';

  /// Analyze an image file using LLaVA
  static Future<String> analyzeImage(File imageFile) async {
    try {
      // Read image file and convert to base64
      final bytes = await imageFile.readAsBytes();
      final base64Image = base64Encode(bytes);

      final response = await http.post(
        Uri.parse(_apiUrl),
        headers: {
          'Authorization': 'Bearer ${ApiKeys.groqApiKey}',
          'Content-Type': 'application/json',
        },
        body: jsonEncode({
          'model': _model,
          'messages': [
            {
              'role': 'user',
              'content': [
                {
                  'type': 'text',
                  'text': '''You are an expert educational tutor analyzing images of academic content.
Analyze this image and:
1. Identify what subject/topic it covers
2. Explain key concepts shown
3. Answer any questions posed
4. Provide learning tips

Be clear, concise, and educational.'''
                },
                {
                  'type': 'image_url',
                  'image_url': {
                    'url': 'data:image/jpeg;base64,$base64Image',
                  }
                }
              ]
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
        throw Exception('Invalid Groq API key');
      } else if (response.statusCode == 429) {
        throw Exception('Rate limit exceeded. Please wait a moment.');
      } else {
        throw Exception('Vision API error: ${response.statusCode} - ${response.body}');
      }
    } catch (e) {
      throw Exception('Error analyzing image: $e');
    }
  }
}