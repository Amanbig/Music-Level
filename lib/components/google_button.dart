import 'package:flutter/material.dart';

class GoogleButton extends StatelessWidget {
  final VoidCallback onPressed;

  const GoogleButton({
    required this.onPressed,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      style: ElevatedButton.styleFrom(
        foregroundColor: Colors.white,
        backgroundColor: Colors.black, // Set button color to black
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12), // Smooth corners
        ),
        elevation: 4, // Slight shadow for depth
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
        minimumSize: const Size(double.infinity, 54), // Full-width button
      ),
      onPressed: onPressed,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Image.network(
            "https://firebasestorage.googleapis.com/v0/b/flutterbricks-public.appspot.com/o/crypto%2Fsearch%20(2).png?alt=media&token=24a918f7-3564-4290-b7e4-08ff54b3c94c",
            width: 20,
            height: 20, // Maintain aspect ratio
          ),
          const SizedBox(width: 16), // Space between icon and text
          const Text(
            'Sign in with Google',
            style: TextStyle(
              color: Colors.white, // White text on black button
              fontSize: 16,
              fontWeight: FontWeight.w600, // Slightly bolder text
            ),
          ),
        ],
      ),
    );
  }
}
