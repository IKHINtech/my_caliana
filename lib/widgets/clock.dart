import 'dart:async';

import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class Clock extends StatefulWidget {
  @override
  _ClockState createState() => _ClockState();
}

class _ClockState extends State<Clock> {
  late Timer _timer;
  DateTime _now = DateTime.now();

  @override
  void initState() {
    super.initState();
    _timer = Timer.periodic(Duration(seconds: 1), (timer) {
      setState(() {
        _now = DateTime.now();
      });
    });
  }

  @override
  void dispose() {
    _timer.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    String formattedDate = DateFormat('EEE, MMM d, yyyy').format(_now);
    String formattedTime = DateFormat('hh:mm:ss a').format(_now);

    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          formattedDate,
          style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
        ),
        Text(
          formattedTime,
          style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
        ),
      ],
    );
  }
}
