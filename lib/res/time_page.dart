// import 'package:flutter/material.dart';
// import 'package:zupee/res/app_colors.dart';
// import 'dart:async';
//
// class CountdownTimer extends StatefulWidget {
//   final Function(int) onTimerTick;
//   final FontWeight fontWeight;
//   final double fontSize;
//   final Color color;
//   final String? futureTime;
//   CountdownTimer({
//     super.key,
//     required this.onTimerTick,
//     required this.fontWeight,
//     required this.fontSize,
//    required this.color,
//      this.futureTime,
//   });
//
//   @override
//   CountdownTimerState createState() => CountdownTimerState();
// }
//
// class CountdownTimerState extends State<CountdownTimer> {
//   late Stream<DateTime> _clockStream;
//    DateTime? _futureTime;
//   @override
//   void initState() {
//     super.initState();
//     _futureTime = DateTime.parse(widget.futureTime.toString());
//     _clockStream = clockStream();
//   }
//
//   Stream<DateTime> clockStream() {
//     return Stream.periodic(const Duration(seconds: 1), (_) => DateTime.now());
//   }
// @override
//   void dispose() {
//     super.dispose();
//   }
//   @override
//   Widget build(BuildContext context) {
//     print(widget.color);
//     return StreamBuilder<DateTime>(
//       stream: _clockStream,
//       builder: (context, snapshot) {
//         if (!snapshot.hasData) {
//           return const SizedBox.shrink();
//         } else {
//           DateTime currentTime = snapshot.data!;
//           // int seconds = 60 - currentTime.second;
//           //
//           // widget.onTimerTick(seconds);
//           int differenceInSeconds = _futureTime!.difference(currentTime).inSeconds;
//           if (differenceInSeconds <= 0) {
//             // If the difference is zero or negative, the timer should be stopped or show as completed
//             differenceInSeconds = 0;
//           }
//           widget.onTimerTick(differenceInSeconds);
//           int hours = differenceInSeconds ~/ 3600;
//           int minutes = (differenceInSeconds % 3600) ~/ 60;
//           int seconds = differenceInSeconds % 60;
//           return Text("${minutes.toString().padLeft(2, '0')}mm:${seconds.toString()}s",
//               style: TextStyle(
//                   fontSize: widget.fontSize,
//                   color: widget.color ,
//                   fontWeight: widget.fontWeight));
//         }
//       },
//     );
//   }
// }

// class TimeContainer extends StatelessWidget {
//   final String time;
//   const TimeContainer({
//     super.key,
//     required this.time,
//   });
//
//   @override
//   Widget build(BuildContext context) {
//     return
//       Text(
//           "${time}s",
//           style: const TextStyle(
//             fontSize: 10,
//             color: red,
//               fontWeight: FontWeight.w500
//           )
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
  final String? futureTime;

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
  late Stream<DateTime> _clockStream;
  DateTime? _futureTime;
  Timer? _timer;

  @override
  void initState() {
    super.initState();
    _futureTime = DateTime.tryParse(widget.futureTime.toString());
    print("_futureTime:$_futureTime");
    _clockStream = clockStream();
  }

  Stream<DateTime> clockStream() {
    return Stream.periodic(const Duration(seconds: 1), (_) => DateTime.now());
  }

  @override
  void dispose() {
    _timer?.cancel(); // Cancel the timer if it's running
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<DateTime>(
      stream: _clockStream,
      builder: (context, snapshot) {
        if (!snapshot.hasData || _futureTime == null) {
          return const SizedBox.shrink(); // Handle null futureTime case
        } else {
          DateTime currentTime = snapshot.data!;
          int differenceInSeconds = _futureTime!.difference(currentTime).inSeconds;
          print("AmanTime:$_futureTime");
          print("AmanCurrentTime:$currentTime");
          // Check if the countdown has ended
          if (differenceInSeconds <= 0) {
            print("differenceInSeconds:$differenceInSeconds");
            differenceInSeconds = 0; // Prevent negative countdown
            widget.onTimerTick(differenceInSeconds); // Notify when the timer hits zero
            _timer?.cancel(); // Stop the timer
          } else {
            widget.onTimerTick(differenceInSeconds);
          }

          int minutes = (differenceInSeconds % 3600) ~/ 60;
          int seconds = differenceInSeconds % 60;

          return Text(
            "${minutes.toString().padLeft(2, '0')}m:${seconds.toString().padLeft(2, '0')}s",
            style: TextStyle(
              fontSize: widget.fontSize,
              color: widget.color,
              fontWeight: widget.fontWeight,
            ),
          );
        }
      },
    );
  }
}
