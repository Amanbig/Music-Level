import 'dart:convert';
import 'dart:io';
import 'package:http/http.dart' as http;
import 'package:flutter_dotenv/flutter_dotenv.dart';

class MusicGenerationService {
  final String apiUrl = "https://api-inference.huggingface.co/models/facebook/musicgen-small";
  final String? apiToken = dotenv.env['API_KEY']; // Replace with your Hugging Face API token

  // Function to generate music based on lyrics
  Future<String> generateMusicFromLyrics(String lyrics, String outputFilePath) async {
    try {
      // Set up the headers for the request
      final headers = {
        "Authorization": "Bearer $apiToken",
        "Content-Type": "application/json",
      };

      // Set up the body data (the lyrics)
      final body = json.encode({"inputs": lyrics});

      // Make a POST request to the MusicGen API
      final response = await http.post(
        Uri.parse(apiUrl),
        headers: headers,
        body: body,
      );

      if (response.statusCode == 200) {
        // If the request was successful, save the music content to the output file
        final file = File(outputFilePath);
        await file.writeAsBytes(response.bodyBytes);

        return outputFilePath; // Return the file path where the music is saved
      } else {
        throw Exception("Error generating music: ${response.statusCode}, ${response.body}");
      }
    } catch (e) {
      throw Exception("Error generating music: $e");
    }
  }
}
// prompt = 'Generate a song matching these lyrics:\ns${lyrics}'