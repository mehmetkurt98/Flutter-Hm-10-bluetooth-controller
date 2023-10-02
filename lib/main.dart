import 'package:flutter/material.dart';
import 'package:flutter_blue/flutter_blue.dart';
import 'package:fluttet_hm10/view/ble_connect.dart';
import 'package:fluttet_hm10/view/home.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:fluttertoast/fluttertoast.dart'; // Ekledik

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  final title = 'Flutter BLE Scan Demo';
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: title,
      home: BleConnnectPage(),
    );
  }
}

