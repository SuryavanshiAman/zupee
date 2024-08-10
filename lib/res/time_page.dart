import 'package:flutter/material.dart';
import 'package:zupee/res/app_colors.dart';
import 'dart:async';

class CountdownTimer extends StatefulWidget {
  final Function(int) onTimerTick;
  final FontWeight fontWeight;
  final double fontSize;
  final Color color;
  CountdownTimer({
    super.key,
    required this.onTimerTick,
    required this.fontWeight,
    required this.fontSize,
   required this.color,
  });

  @override
  CountdownTimerState createState() => CountdownTimerState();
}

class CountdownTimerState extends State<CountdownTimer> {
  late Stream<DateTime> _clockStream;

  @override
  void initState() {
    super.initState();
    _clockStream = clockStream();
  }

  Stream<DateTime> clockStream() {
    return Stream.periodic(const Duration(seconds: 1), (_) => DateTime.now());
  }
@override
  void dispose() {
    super.dispose();
  }
  @override
  Widget build(BuildContext context) {
    print(widget.color);
    return StreamBuilder<DateTime>(
      stream: _clockStream,
      builder: (context, snapshot) {
        if (!snapshot.hasData) {
          return const SizedBox.shrink();
        } else {
          DateTime currentTime = snapshot.data!;
          int seconds = 60 - currentTime.second;
          widget.onTimerTick(seconds);
          return Text("00m:${seconds.toString()}s",
              style: TextStyle(
                  fontSize: widget.fontSize,
                  color: widget.color ,
                  fontWeight: widget.fontWeight));
        }
      },
    );
  }
}

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
