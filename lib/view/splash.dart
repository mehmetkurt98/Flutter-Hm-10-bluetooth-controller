import 'package:bluetooth_enable_fork/bluetooth_enable_fork.dart';
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'dart:async';
import '../controller/twoclickforexit.dart';
import 'ble_connect.dart';

class SplashScreen extends StatefulWidget {
  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {


  Future ble() async{
      BluetoothEnable.enableBluetooth.then((result) {
      if (result == "true") {
        // Bluetooth has been enabled
        Future.delayed(Duration(seconds: 2),(){
          Navigator.pushReplacement(
            context,
            PageRouteBuilder(
              pageBuilder: (context, animation, secondaryAnimation) =>
                  BleConnnectPage(),
              transitionsBuilder: (context, animation, secondaryAnimation, child) {
                const begin = Offset(0.0, 1.0);
                const end = Offset.zero;
                const curve = Curves.easeInOut;
                var tween = Tween(begin: begin, end: end).chain(CurveTween(curve: curve));
                var offsetAnimation = animation.drive(tween);
                return SlideTransition(
                  position: offsetAnimation,
                  child: child,
                );
              },
            ),
          );


        });

      }
      else if (result == "false") {
        // Bluetooth has not been enabled
      }
    });
  }
  @override
  void initState() {
    super.initState();
    ble();

  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: DoubleBackExitApp(
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Lottie.asset("assets/bluetooth.json"),

              /*
              SizedBox(
                width: MediaQuery.of(context).size.width, // Genişliği yarıya indir
                height: MediaQuery.of(context).size.height, // Yüksekliği yarıya indir
                child: Center(child: Image.asset("assets/mob.gif", fit: BoxFit.cover)),
              ),

               */
            ],
          ),
        ),
      ),
    );
  }
}
