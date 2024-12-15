import 'package:flutter/material.dart';
import 'package:music_level/components/auth_comp.dart';
import 'package:music_level/components/google_button.dart'; // Import GoogleButton

class SignUpPage extends StatelessWidget {
  const SignUpPage({super.key});

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
                'Sign Up',
                style: TextStyle(
                  fontSize: 32,
                  fontWeight: FontWeight.bold,
                  color: Colors.white, // White text color
                ),
              ),
              const SizedBox(height: 40),
              // Using EmailPasswordWidget with isSignUp: true for Sign Up
              const EmailPasswordWidget(isSignUp: true),
              const SizedBox(height: 20),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Text(
                    'Already have an account?',
                    style: TextStyle(color: Colors.white), // White text
                  ),
                  TextButton(
                    onPressed: () {
                      // Navigate to the Login page
                      Navigator.pushNamed(context, '/login');
                    },
                    child: const Text(
                      'Login',
                      style: TextStyle(
                        color: Colors.amber, // Button color
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 20),
              GoogleButton(
                onPressed: () {
                  // Handle Google sign-up logic here
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
