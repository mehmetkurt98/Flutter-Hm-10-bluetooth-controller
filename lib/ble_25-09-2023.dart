/*
import 'package:flutter/material.dart';
import 'package:flutter_blue/flutter_blue.dart';
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
      home: MyHomePage(title: title),
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key? key, required this.title}) : super(key: key);
  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  FlutterBlue flutterBlue = FlutterBlue.instance;
  List<ScanResult> scanResultList = [];
  bool _isScanning = false;
  BluetoothDevice? selectedDevice;

  @override
  void initState() {
    super.initState();
    _isScanning = false;
  }

  Future<void> scan() async {
    Map<Permission, PermissionStatus> statuses = await [
      Permission.bluetoothScan,
      Permission.bluetoothAdvertise,
      Permission.bluetoothConnect
    ].request();

    if (statuses[Permission.bluetoothScan] == PermissionStatus.granted &&
        statuses[Permission.bluetoothScan] == PermissionStatus.granted) {
      if (!_isScanning) {
        scanResultList.clear();
        flutterBlue.startScan(timeout: Duration(seconds: 4));
        flutterBlue.scanResults.listen((results) {
          setState(() {
            scanResultList = results;
          });
        });
      } else {
        flutterBlue.stopScan();
      }

      setState(() {
        _isScanning = !_isScanning;
      });
    }
  }

  Future<void> connectToDevice(BluetoothDevice device) async {
    try {
      await device.connect();
      setState(() {
        selectedDevice = device;
      });
      // Bağlantı başarılı olduğunda Toast mesajı göster
      Fluttertoast.showToast(
        msg: "Bağlantı başarılı",
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.BOTTOM,
        backgroundColor: Colors.green,
        textColor: Colors.white,
      );
    } catch (e) {
      print("Cihaza bağlanırken hata oluştu: $e");
      // Bağlantı başarısız olduğunda Toast mesajı göster
      Fluttertoast.showToast(
        msg: "Bağlantı başarısız",
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.BOTTOM,
        backgroundColor: Colors.red,
        textColor: Colors.white,
      );
    }
  }

  Future<void> disconnectFromDevice() async {
    if (selectedDevice != null) {
      await selectedDevice!.disconnect();
      setState(() {
        selectedDevice = null;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: Center(
        child: ListView.separated(
          itemCount: scanResultList.length,
          itemBuilder: (context, index) {
            return ListTile(
              onTap: () {
                connectToDevice(scanResultList[index].device);
              },
              title: Text(scanResultList[index].device.name),
              subtitle: Text(scanResultList[index].device.id.id),
            );
          },
          separatorBuilder: (BuildContext context, int index) {
            return Divider();
          },
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: scan,
        child: Icon(_isScanning ? Icons.stop : Icons.search),
      ),
    );
  }
}

 */