import 'dart:async';
import 'package:flutter/material.dart';

class CounterTime extends StatefulWidget {
  final int minutes;
  final TextStyle? style;
  final VoidCallback? onReset;
  final VoidCallback? onTimeEnd;

  const CounterTime({
    this.minutes = 1,
    this.style,
    this.onReset,
    this.onTimeEnd,
    Key? key,
  }) : super(key: key);

  @override
  State<CounterTime> createState() => _CounterTimeState();
}

class _CounterTimeState extends State<CounterTime> {
  final remainTime = ValueNotifier('');
  late int initTime;
  Timer? timer;
  String _displayTimeWithDuration(Duration duration) {
    return <int>[duration.inMinutes, duration.inSeconds]
        .map((int e) => e.remainder(60).toString().padLeft(2, "0"))
        .join(':');
  }

  @override
  void initState() {
    initTime = widget.minutes * 60;
    WidgetsBinding.instance.addPostFrameCallback((_) {
      startTime();
    });
    super.initState();
  }

  void startTime() {
    remainTime.value = _displayTimeWithDuration(
      Duration(seconds: initTime),
    );
    timer?.cancel();
    timer = Timer.periodic(
      const Duration(seconds: 1),
      (tick) {
        var duration = Duration(seconds: initTime - tick.tick);
        if (initTime - tick.tick == 0) {
          tick.cancel();
          widget.onTimeEnd?.call();
        }
        remainTime.value = _displayTimeWithDuration(duration);
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder(
      valueListenable: remainTime,
      builder: (_, String time, __) {
        return Text(
          time,
          style: widget.style ?? Theme.of(context).textTheme.bodyText2,
        );
      },
    );
  }
}
