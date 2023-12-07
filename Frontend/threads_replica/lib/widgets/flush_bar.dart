import 'package:another_flushbar/flushbar.dart';
import 'package:flutter/material.dart';

Flushbar<dynamic> flushBar(String text, Color color) {
  return Flushbar(
    backgroundColor: Colors.transparent,
    borderRadius: BorderRadius.circular(8),
    boxShadows: const [
      BoxShadow(
        color: Colors.black54,
        blurRadius: 4,
        offset: Offset(0, 2),
      ),
    ],
    padding: const EdgeInsets.all(15),
    messageText: Text(
      text,
      style: TextStyle(fontSize: 12, color: color),
    ),
    duration: const Duration(seconds: 2),
  );
}
