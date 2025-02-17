import 'package:flutter/material.dart';

class SquareProgressIndicator extends StatelessWidget {
  final int secondsRemaining;

  SquareProgressIndicator({required this.secondsRemaining});

  @override
  Widget build(BuildContext context) {
    double progress = secondsRemaining / 35;

    return Scaffold(
      body : Column(
        children: [
          Center(
            child: Container(
              width: 100,  // Square width
              height: 100, // Square height
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(8),  // Optional: rounded corners for visual appeal
                color: Colors.grey[300],  // Background color
              ),
              child: Stack(
                children: [
                  // This is the background layer
                  Positioned.fill(
                    child: Container(
                      color: Colors.grey[200], // Background color of the square
                    ),
                  ),
                  // Progress layer
                  Positioned.fill(
                    child: FractionallySizedBox(
                      alignment: Alignment.center,
                      widthFactor: progress,  // Sets how much the progress bar fills
                      child: Container(
                        color: Colors.blue, // Progress color
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
