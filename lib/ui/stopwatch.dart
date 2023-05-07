import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:stopwatch_flutter/ui/stopwatch_renderer.dart';

class Stopwatch extends StatefulWidget {
  @override
  _StopwatchState createState() => _StopwatchState();
}

class _StopwatchState extends State<Stopwatch>
    with SingleTickerProviderStateMixin {
  late DateTime _initialTime;

  bool _isRunning = true;

  Duration _previouslyElapsed = Duration.zero;
  Duration _currentlyElapsed = Duration.zero;

  Duration get _elapsed => _previouslyElapsed + _currentlyElapsed;

  late final Ticker _ticker;

  @override
  void initState() {
    // TODO: implement initState

    _initialTime = DateTime.now();

    _ticker = this.createTicker((elapsed) {
      final now = DateTime.now();
      setState(() {
        _currentlyElapsed = now.difference(_initialTime);
      });
    });

    _ticker.start();

    super.initState();
  }

  @override
  void dispose() {
    _ticker.dispose();
    // TODO: implement dispose
    super.dispose();
  }

  void _toggleRuning() {
    setState(() {
      _isRunning = !_isRunning;
      if (_isRunning) {
        _ticker.start();
      } else {
        _ticker.stop();
        // _previouslyElapsed += _currentlyElapsed;

        // _currentlyElapsed = Duration.zero;
      }
    });
  }

  void _reset() {
    _ticker.stop();

    setState(() {
      _isRunning = false;
      _previouslyElapsed = Duration.zero;
      _currentlyElapsed = Duration.zero;
    });
  }

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        return StopwatchRenderer(
          isRunning: _isRunning,
          start: _toggleRuning,
          radius: constraints.maxWidth / 2,
          elapsed: _elapsed,
          reset: _reset,
        );
      },
    );
  }
}
