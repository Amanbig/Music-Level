import 'package:flutter/material.dart';
import 'package:music_level/components/google_button.dart'; // Import GoogleButton
import 'package:music_level/services/appwrite_service.dart'; // Import AppwriteService

class LoginPage extends StatelessWidget {
  const LoginPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black, // Dark background
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                'Login',
                style: TextStyle(
                  fontSize: 32,
                  fontWeight: FontWeight.bold,
                  color: Colors.white, // White text color
                ),
              ),
              const SizedBox(height: 40),
              // GoogleButton with sign-in logic
              GoogleButton(
                onPressed: () async {
                  try {
                    // Show loading indicator or update UI before sign-in attempt
                    showDialog(
                      context: context,
                      builder: (context) => const Center(
                        child: CircularProgressIndicator(),
                      ),
                    );

                    // Call Appwrite service to sign in with Google
                    final user = await AppwriteService().signInWithGoogle();

                    // Dismiss the loading indicator
                    Navigator.of(context).pop();

                    if (user != null) {
                      // If sign-in is successful, navigate to the next page
                      // For example: navigate to the home page
                      Navigator.pushReplacementNamed(context, '/home');
                    } else {
                      // Handle error or show failure message
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(content: Text('Google sign-in failed')),
                      );
                    }
                  } catch (e) {
                    // Handle any error during Google sign-in
                    Navigator.of(context).pop(); // Dismiss the loading
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(content: Text('Error: $e')),
                    );
                  }
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
