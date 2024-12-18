import 'package:audioplayers/audioplayers.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class MusicPreviewPage extends StatefulWidget {
  final String musicType;
  final String lyrics;
  final String audioUrl; // URL for the audio track

  const MusicPreviewPage({
    Key? key,
    required this.musicType,
    required this.lyrics,
    required this.audioUrl,
  }) : super(key: key);

  @override
  _MusicPreviewPageState createState() => _MusicPreviewPageState();
}

class _MusicPreviewPageState extends State<MusicPreviewPage> {
  final AudioPlayer _audioPlayer = AudioPlayer();
  bool isPlaying = false;
  bool isMuted = false;
  double currentTime = 0;
  double totalDuration = 1;

  @override
  void initState() {
    super.initState();
    // Listen to position changes to update current time
    _audioPlayer.onPositionChanged.listen((Duration p) {
      setState(() {
        currentTime = p.inSeconds.toDouble();
      });
    });
    // Listen to duration changes to update total duration
    _audioPlayer.onDurationChanged.listen((Duration d) {
      setState(() {
        totalDuration = d.inSeconds.toDouble();
      });
    });
  }

  @override
  void dispose() {
    _audioPlayer.dispose();
    super.dispose();
  }

  void _playPauseMusic() async {
    if (isPlaying) {
      await _audioPlayer.pause();
    } else {
      // Play the audio from the URL
      await _audioPlayer.play(Uri.parse(widget.audioUrl) as Source);
    }
    setState(() {
      isPlaying = !isPlaying;
    });
  }


  void _skipForward() {
    final newPosition = currentTime + 15; // Skip forward 15 seconds
    _audioPlayer.seek(Duration(seconds: newPosition.toInt()));
  }

  void _skipBackward() {
    final newPosition = currentTime - 15; // Skip backward 15 seconds
    _audioPlayer.seek(Duration(seconds: newPosition.toInt()));
  }

  void _onSliderChanged(double value) {
    _audioPlayer.seek(Duration(seconds: value.toInt()));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        title: Text(
          'Music Preview',
          style: GoogleFonts.poppins(
            color: Colors.white,
            fontWeight: FontWeight.bold,
          ),
        ),
        backgroundColor: Colors.black,
        elevation: 0,
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Stack(
            children: [

              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Music Type Section
                  Text(
                    'Music Type:',
                    style: GoogleFonts.poppins(
                      fontSize: 18,
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 10),
                  Container(
                    padding: const EdgeInsets.symmetric(horizontal: 12),
                    decoration: BoxDecoration(
                      color: Colors.grey[900],
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: Text(
                      widget.musicType,
                      style: GoogleFonts.poppins(color: Colors.white, fontSize: 16),
                    ),
                  ),

                  const SizedBox(height: 20),

                  // Audio Player with Play, Pause, Skip Buttons
                  Center(
                    child: Column(
                      children: [
                        Text(
                          'Preview the Music',
                          style: GoogleFonts.poppins(
                            fontSize: 18,
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        const SizedBox(height: 20),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            // Skip Backward Button
                            IconButton(
                              onPressed: _skipBackward,
                              icon: Icon(
                                Icons.skip_previous,
                                color: Colors.white,
                                size: 32,
                              ),
                            ),
                            // Play/Pause Button
                            IconButton(
                              onPressed: _playPauseMusic,
                              icon: Icon(
                                isPlaying ? Icons.pause : Icons.play_arrow,
                                color: Colors.white,
                                size: 32,
                              ),
                            ),
                            // Skip Forward Button
                            IconButton(
                              onPressed: _skipForward,
                              icon: Icon(
                                Icons.skip_next,
                                color: Colors.white,
                                size: 32,
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(height: 20),

                        // Music Slider
                        Slider(
                          value: currentTime,
                          min: 0,
                          max: totalDuration,
                          onChanged: _onSliderChanged,
                          activeColor: Colors.white,
                          inactiveColor: Colors.grey,
                        ),

                        const SizedBox(height: 10),
                        // Display Current Time and Total Duration
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              '${currentTime.toInt()}s',
                              style: GoogleFonts.poppins(color: Colors.white),
                            ),
                            const SizedBox(width: 10),
                            Text(
                              '${totalDuration.toInt()}s',
                              style: GoogleFonts.poppins(color: Colors.white),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                  // Lyrics Section
                  Text(
                    'Lyrics Preview:',
                    style: GoogleFonts.poppins(
                      fontSize: 18,
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 10),
                  Container(
                    padding: const EdgeInsets.all(16.0),
                    decoration: BoxDecoration(
                      color: Colors.grey[900],
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: Text(
                      widget.lyrics,
                      style: GoogleFonts.poppins(color: Colors.white, fontSize: 16),
                    ),
                  ),

                  const SizedBox(height: 30),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
