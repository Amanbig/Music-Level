import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:google_generative_ai/google_generative_ai.dart';

Future<String> generateLyrics(String prompt) async {
  var apiKey = dotenv.env['API_KEY']; // Replace with your actual API key

  // Initialize the Gemini model
  final model = GenerativeModel(
    model: 'gemini-1.5-flash',
    apiKey: apiKey!,
  );

  try {
    // Use the model to generate content
    final response = await model.generateContent([
      Content.text(prompt),
    ]);

    // Return the generated text
    return response.text ?? 'No lyrics generated.';
  } catch (e) {
    print('Error generating lyrics: $e');
    return 'Error: $e';
  }
}

void main() async {
  // Example prompt for lyric generation
  String prompt = "Write a pop song about hope and resilience.";
  String lyrics = await generateLyrics(prompt);

  // Print the generated lyrics
  print("Generated Lyrics:\n$lyrics");
}
