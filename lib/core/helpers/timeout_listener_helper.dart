import 'dart:async';

import 'package:flutter/widgets.dart';

class TimeOutListener extends StatefulWidget {
  const TimeOutListener({
    super.key,
    required this.child,
    required this.duration,
    required this.onTimeOut,
  });
  final Widget child;
  final Duration duration;
  final VoidCallback onTimeOut;

  @override
  State<TimeOutListener> createState() => _TimeOutListenerState();
}

class _TimeOutListenerState extends State<TimeOutListener> {
  Timer? _timer;

  _startTimer() {
    if (_timer != null) {
      _timer?.cancel();
      _timer = null;
    }

    _timer = Timer(widget.duration, () {
      widget.onTimeOut();
      _startTimer();
    });
  }

  @override
  void initState() {
    _startTimer();
    super.initState();
  }

  @override
  void dispose() {
    if (_timer != null) {
      _timer?.cancel();
      _timer = null;
    }
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Listener(
      behavior: HitTestBehavior.translucent,
      onPointerDown: (event) {
        _startTimer();
      },
      child: widget.child,
    );
  }
}
