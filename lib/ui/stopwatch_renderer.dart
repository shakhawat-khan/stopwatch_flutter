import 'dart:math';

import 'package:flutter/material.dart';
import 'package:stopwatch_flutter/ui/clock_hand.dart';
import 'package:stopwatch_flutter/ui/clock_markers.dart';
import 'package:stopwatch_flutter/ui/elapsed_time_text.dart';
import 'package:stopwatch_flutter/ui/reset_button.dart';
import 'package:stopwatch_flutter/ui/start_stop_button.dart';

class StopwatchRenderer extends StatelessWidget {
  final double radius;
  final Duration elapsed;
  final VoidCallback? start;
  final VoidCallback? reset;
  final bool isRunning;
  const StopwatchRenderer(
      {Key? key,
      required this.isRunning,
      required this.radius,
      required this.elapsed,
      this.start,
      this.reset})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        // Container(
        //   decoration: BoxDecoration(
        //       border: Border.all(width: 3, color: Colors.orange),
        //       borderRadius: BorderRadius.circular(radius)),
        // ),

        for (var i = 0; i < 60; i++)
          Positioned(
              left: radius,
              top: radius,
              child: ClockSecondsTickMarker(seconds: i, radius: radius)),

        for (var i = 5; i <= 60; i = i + 5)
          Positioned(
            top: radius,
            left: radius,
            child: ClockTextMarker(value: i, maxValue: 60, radius: radius),
          ),

        Positioned(
          left: radius,
          top: radius,
          child: ClockHand(
            rotationZAngle: pi + (2 * pi / 60000) * elapsed.inMilliseconds,
            handThickness: 2,
            handLength: radius,
            color: Colors.orange,
          ),
        ),

        Align(
          alignment: Alignment.bottomLeft,
          child: SizedBox(
              height: 50,
              width: 50,
              child: ResetButton(
                onPressed: reset,
              )),
        ),

        Align(
          alignment: Alignment.bottomRight,
          child: SizedBox(
              height: 50,
              width: 50,
              child: StartStopButton(onPressed: start, isRunning: isRunning)),
        ),

        // Transform(
        //   transform: Matrix4.identity()
        //     ..translate(50.0, 0.0, 0.0)
        //     ..rotateZ(pi / 4),
        //   alignment: Alignment.center,
        //   child: Container(
        //     color: Colors.amber,
        //   ),
        // ),
        Positioned(
          left: 0,
          right: 0,
          top: radius * 1.3,
          child: ElapsedTimeText(
            elapsed: elapsed,
          ),
        ),

        // for (var i = 0; i < 60; i++)
        //   Positioned(
        //     left: radius,
        //     top: radius,
        //     child: ClockSecondsTickMarker(seconds: i, radius: radius),
        //   ),
        // for (var i = 5; i <= 60; i += 5)
        //   Positioned(
        //     top: radius,
        //     left: radius,
        //     child: ClockTextMarker(value: i, maxValue: 60, radius: radius),
        //   ),
      ],
    );
  }
}
