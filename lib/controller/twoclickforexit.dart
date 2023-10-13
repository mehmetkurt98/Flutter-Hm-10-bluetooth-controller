import 'package:flutter/material.dart';

class DoubleBackExitApp extends StatefulWidget {
  final Widget child;

  DoubleBackExitApp({required this.child});

  @override
  _DoubleBackExitAppState createState() => _DoubleBackExitAppState();
}

class _DoubleBackExitAppState extends State<DoubleBackExitApp> {
  DateTime? _lastPressedAt;

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        bool shouldExit = _lastPressedAt == null ||
            DateTime.now().difference(_lastPressedAt!) > Duration(seconds: 2);

        if (shouldExit) {
          _lastPressedAt = DateTime.now();
          final snackBar = SnackBar(
            content: Text('Çıkmak için tekrar geri tuşuna basın'),
            duration: Duration(seconds: 2),
          );
          ScaffoldMessenger.of(context).showSnackBar(snackBar);
          return false;
        }
        return true;
      },
      child: widget.child,
    );
  }
}
