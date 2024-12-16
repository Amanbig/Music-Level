import 'package:http/http.dart' as http;
import 'dart:convert';
import 'dart:io';

Future<File> generateBackgroundMusic(String genre, String mood) async {
  final url = "https://api.aiva.ai/generate_music"; // Replace with actual API endpoint
  final headers = {
    'Authorization': 'Bearer YOUR_AIVA_API_KEY',
    'Content-Type': 'application/json',
  };
  final body = jsonEncode({
    'genre': genre,
    'mood': mood,
    'duration': 180, // Duration in seconds
  });

  try {
    final response = await http.post(Uri.parse(url), headers: headers, body: body);
    if (response.statusCode == 200) {
      // Assuming API returns music as a downloadable link
      final musicUrl = jsonDecode(response.body)['music_url'];
      final musicData = await http.get(Uri.parse(musicUrl));
      final file = File('background_music.mp3');
      await file.writeAsBytes(musicData.bodyBytes);
      return file;
    } else {
      throw Exception('Music generation failed: ${response.body}');
    }
  } catch (e) {
    print('Error generating music: $e');
    return File('');
  }
}

void main() async {
  final musicFile = await generateBackgroundMusic("Pop", "Hopeful");
  print("Generated Music: ${musicFile.path}");
}
