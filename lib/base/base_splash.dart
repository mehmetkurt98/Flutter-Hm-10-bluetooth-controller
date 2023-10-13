/*
import 'package:bluetooth_enable_fork/bluetooth_enable_fork.dart';
import 'package:flutter/material.dart';
import 'package:flutter_blue/flutter_blue.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:permission_handler/permission_handler.dart';

import '../controller/twoclickforexit.dart';
import 'ble_connect.dart'; // Permission kütüphanesini ekledik

class SplashScreen extends StatefulWidget {
  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {

  Future ble() async{
    BluetoothEnable.enableBluetooth.then((result) {
      if (result == "true") {
        // Bluetooth has been enabled
      }
      else if (result == "false") {
        // Bluetooth has not been enabled
      }
    });
  }


  Future<void> askToEnableBluetooth() async {
    // Bluetooth izinlerini kontrol et
    var status = await Permission.bluetooth.status;

    // Bluetooth kapalıysa kullanıcıya Bluetooth'u açması için bir istem göster
    if (status.isDenied) {
      await Permission.bluetooth.request();
    }
  }



  Future<void> PermissionBle() async {
    Map<Permission, PermissionStatus> statuses = await [
      Permission.bluetoothScan,
      Permission.bluetoothAdvertise,
      Permission.bluetoothConnect
    ].request();

  }
  Future<void> checkBluetoothStatus() async {
    FlutterBlue flutterBlue = FlutterBlue.instance;

    // Bluetooth izinlerini kontrol et
    var status = await Permission.bluetooth.status;

    if (status.isDenied) {
      // Bluetooth izni yoksa, kullanıcıdan izin iste
      await Permission.bluetooth.request();
    }

    bool isBluetoothEnabled = await flutterBlue.isOn;

    if (!isBluetoothEnabled) {
      // Bluetooth kapalı, kullanıcıyı açması için uyarı ver
      showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: Text("Bluetooth Kapalı"),
            content: Text("Bluetooth'u açmalısınız. Lütfen Bluetooth'u açın."),
            actions: <Widget>[
              ElevatedButton(
                child: Text("Bluetooth Aç"),
                onPressed: () async {
                  ble();
                  //askToEnableBluetooth();
                  Navigator.of(context).pop(); // AlertDialog'ı kapat

                },
              ),
            ],
          );
        },
      );
    } else {
      // Bluetooth açık, istediğiniz işlemi yapabilirsiniz.
    }
  }

  @override
  void initState() {
    super.initState();
    checkBluetoothStatus();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: DoubleBackExitApp(
        child: Stack(
          children: <Widget>[
            // Arka plan resmi
            Container(
              width: MediaQuery.of(context).size.width,
              height: MediaQuery.of(context).size.height,
              decoration: BoxDecoration(
                image: DecorationImage(
                  image: AssetImage('assets/splash.jpg'),
                  fit: BoxFit.cover,
                ),
              ),
            ),
            // Diğer widgetler
            Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  // Diğer widgetler burada
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

 */