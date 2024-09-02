import 'dart:async'; // Import this for the Timer class
import 'package:flutter/material.dart';

class TimerProvider with ChangeNotifier {
  Timer? _timer;
  int _remainingSeconds = 300; // Default timer duration
  bool _isTimerRunning = false;

  int get remainingSeconds => _remainingSeconds;
  bool get isTimerRunning => _isTimerRunning;

  // Setter method for remaining seconds
  set remainingSeconds(int value) {
    if (value < 0) {
      _remainingSeconds =300; // Ensure seconds don't go below 0
    } else {
      _remainingSeconds = value;
    }
    notifyListeners();
  }
  String get timerText {
    int minutes = _remainingSeconds ~/ 60;
    int seconds = _remainingSeconds % 60;
    return '${minutes.toString().padLeft(2, '0')}:${seconds.toString().padLeft(2, '0')}';
  }
  void startTimer() {
    if (_isTimerRunning) return; // Prevent multiple timers

    _isTimerRunning = true;
    notifyListeners();

    _timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      if (_remainingSeconds > 0) {
        _remainingSeconds--;
        notifyListeners();
        if (_remainingSeconds == 0) {
          _timer?.cancel();
          _isTimerRunning = false;
          notifyListeners();
          // Optionally navigate to another screen
          // Navigator.pushReplacementNamed(context, RoutesName.winnerScreen);
        }
      } else {
        _timer?.cancel();
        _isTimerRunning = false;
        notifyListeners();
      }
    });
  }

  void stopTimer() {
    _timer?.cancel();
    _isTimerRunning = false;
    notifyListeners();
  }

  void resetTimer(int duration) {
    _remainingSeconds = duration;
    notifyListeners();
  }
}