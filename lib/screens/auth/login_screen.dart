import 'package:flutter/material.dart';
import 'package:music_level/components/auth_comp.dart';
import 'package:music_level/components/google_button.dart'; // Import GoogleButton

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
              // Using EmailPasswordWidget with isSignUp: false for Login
              const EmailPasswordWidget(isSignUp: false),
              const SizedBox(height: 20),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Text(
                    'Don\'t have an account?',
                    style: TextStyle(color: Colors.white), // White text
                  ),
                  TextButton(
                    onPressed: () {
                      // Navigate to the Sign Up page
                      Navigator.pushNamed(context, '/signup');
                    },
                    child: const Text(
                      'Sign Up',
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
                  // Handle Google sign-in logic here
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
