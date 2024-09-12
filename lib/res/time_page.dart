
// import 'package:flutter/material.dart';
// import 'dart:async';
//
// class CountdownTimer extends StatefulWidget {
//   final Function(int) onTimerTick;
//   final FontWeight fontWeight;
//   final double fontSize;
//   final Color color;
//   final String? futureTime;
//
//   const CountdownTimer({
//     super.key,
//     required this.onTimerTick,
//     required this.fontWeight,
//     required this.fontSize,
//     required this.color,
//     this.futureTime,
//   });
//
//   @override
//   CountdownTimerState createState() => CountdownTimerState();
// }
//
// class CountdownTimerState extends State<CountdownTimer> {
//   late Stream<DateTime> _clockStream;
//   DateTime? _futureTime;
//   Timer? _timer;
//
//   @override
//   void initState() {
//     super.initState();
//     _futureTime = DateTime.tryParse(widget.futureTime.toString());
//     print("_futureTime:$_futureTime");
//     _clockStream = clockStream();
//   }
//
//   Stream<DateTime> clockStream() {
//     return Stream.periodic(const Duration(seconds: 1), (_) => DateTime.now());
//   }
//
//   @override
//   void dispose() {
//     _timer?.cancel(); // Cancel the timer if it's running
//     super.dispose();
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return StreamBuilder<DateTime>(
//       stream: _clockStream,
//       builder: (context, snapshot) {
//         if (!snapshot.hasData || _futureTime == null) {
//           return const SizedBox.shrink(); // Handle null futureTime case
//         } else {
//           DateTime currentTime = snapshot.data!;
//           int differenceInSeconds = _futureTime!.difference(currentTime).inSeconds;
//           if (differenceInSeconds <= 0) {
//             differenceInSeconds = 0; // Prevent negative countdown
//             widget.onTimerTick(differenceInSeconds); // Notify when the timer hits zero
//             _timer?.cancel(); // Stop the timer
//           } else {
//             widget.onTimerTick(differenceInSeconds);
//           }
//
//           int minutes = (differenceInSeconds % 3600) ~/ 60;
//           int seconds = differenceInSeconds % 60;
//
//           return Text(
//             "${minutes.toString().padLeft(2, '0')}m:${seconds.toString().padLeft(2, '0')}s",
//             style: TextStyle(
//               fontSize: widget.fontSize,
//               color: widget.color,
//               fontWeight: widget.fontWeight,
//             ),
//           );
//         }
//       },
//     );
//   }
// }
import 'package:flutter/material.dart';
import 'dart:async';

class CountdownTimer extends StatefulWidget {
  final Function(int) onTimerTick;
  final FontWeight fontWeight;
  final double fontSize;
  final Color color;
  final String? futureTime; // Expected to be a seconds value

  const CountdownTimer({
    super.key,
    required this.onTimerTick,
    required this.fontWeight,
    required this.fontSize,
    required this.color,
    this.futureTime,
  });

  @override
  CountdownTimerState createState() => CountdownTimerState();
}

class CountdownTimerState extends State<CountdownTimer> {
  Timer? _timer;
  int _remainingSeconds = 0;
  int _initialSeconds = 0;

  @override
  void initState() {
    super.initState();
    _initializeTimer(); // Initialize timer with the futureTime value
  }

  void _initializeTimer() {
    // Parse futureTime (which is in seconds) and initialize the remaining seconds
    _initialSeconds = int.tryParse(widget.futureTime ?? '0') ?? 0;
    _remainingSeconds = int.tryParse(widget.futureTime ?? '0') ?? 0;

    // Start the countdown timer if _remainingSeconds is greater than 0
    if (_remainingSeconds > 0) {
      _timer = Timer.periodic(const Duration(seconds: 1), (timer) {
        setState(() {
          if (_remainingSeconds > 0) {
            _remainingSeconds--;
            widget.onTimerTick(_remainingSeconds); // Notify the parent widget
          } else {
            _resetTimer();
            // _timer?.cancel(); // Stop the timer when it reaches 0
          }
        });
      });
    }
  }
  void _resetTimer() {
    // Reset the timer to the initial seconds and restart the countdown
    _remainingSeconds = _initialSeconds;
    widget.onTimerTick(_remainingSeconds); // Notify the parent widget that the timer has reset
  }
  @override
  void dispose() {
    _timer?.cancel(); // Cancel the timer if it's running
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    int minutes = (_remainingSeconds % 3600) ~/ 60;
    int seconds = _remainingSeconds % 60;

    return Text(
      "${minutes.toString().padLeft(2, '0')}m:${seconds.toString().padLeft(2, '0')}s",
      style: TextStyle(
        fontSize: widget.fontSize,
        color: widget.color,
        fontWeight: widget.fontWeight,
      ),
    );
  }
}
