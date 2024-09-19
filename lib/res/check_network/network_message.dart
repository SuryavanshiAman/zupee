import 'package:flutter/material.dart';

class NetworkErrorScreen extends StatelessWidget {
  final String message;
  final VoidCallback onRetry;

  const NetworkErrorScreen({Key? key, required this.onRetry,required this.message}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              // Icon or image for the network error
              Icon(
                Icons.warning_amber_rounded, // Replace with the image asset from your image file if needed
                size: 100,
                color: Colors.purple, // Match the color with the image icon in the photo
              ),
              const SizedBox(height: 20),

              // Error message text
              const Text(
                "Unable to connect with our servers. Please check your internet connection.",
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 18,
                  color: Colors.black54,
                ),
              ),
              const SizedBox(height: 30),

              // Retry button
              ElevatedButton(
                onPressed: onRetry,
                style: ElevatedButton.styleFrom(
                  foregroundColor: Colors.purple, backgroundColor: Colors.yellow, // Text color
                  padding: const EdgeInsets.symmetric(horizontal: 40, vertical: 15),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8),
                  ),
                ),
                child: const Text(
                  "Try Again",
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
