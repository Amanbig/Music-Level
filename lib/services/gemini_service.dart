import 'package:gemini_flutter/gemini_flutter.dart';

Future<String> generateLyrics(String prompt) async {
  final geminiService = GeminiService(apiKey: 'YOUR_GEMINI_API_KEY');
  try {
    final response = await geminiService.generate(
      model: 'gemini-1.5-flash',
      prompt: prompt,
    );
    return response.text; // Extract the generated lyrics
  } catch (e) {
    print('Error generating lyrics: $e');
    return '';
  }
}

void main() async {
  String prompt = "Write a pop song about hope and resilience.";
  String lyrics = await generateLyrics(prompt);
  print("Generated Lyrics: \n$lyrics");
}
