import 'dart:async';
import 'package:flutter/material.dart';

class OTPTimer extends StatefulWidget {
  final VoidCallback onResend;

  const OTPTimer({required this.onResend, super.key});

  @override
  State<OTPTimer> createState() => _OTPTimerState();
}

class _OTPTimerState extends State<OTPTimer> {
  int sec = 60;
  Timer? timer;

  @override
  void initState() {
    super.initState();
    timer = Timer.periodic(const Duration(seconds: 1), (_) {
      if (sec == 0) {
        timer?.cancel();
      } else {
        setState(() => sec--);
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return sec == 0
        ? TextButton(
      onPressed: widget.onResend,
      child: const Text("Resend"),
    )
        : Text("00:${sec.toString().padLeft(2, '0')}");
  }
}
