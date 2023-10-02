import 'package:flutter/material.dart';
import 'package:flutter_blue/flutter_blue.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:fluttertoast/fluttertoast.dart';

import 'home.dart'; // Ekledik

class BleConnnectPage extends StatefulWidget {
  const BleConnnectPage({Key? key}) : super(key: key);

  @override
  State<BleConnnectPage> createState() => _BleConnnectPageState();
}

class _BleConnnectPageState extends State<BleConnnectPage> {
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
      Navigator.of(context).push(
        MaterialPageRoute(
          builder: (context) => Home(connectedDevice: device),
        ),
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
        title: Text("BAĞLANTI SAYFASI"),
      ),
      body: Center(
          child: ListView.separated(
            itemCount: scanResultList.length,
            itemBuilder: (context, index) {
              BluetoothDevice device = scanResultList[index].device;

              // Cihaz adı "cv" ile başlıyorsa göster
              if (device.name != null && device.name.startsWith("BT")) {
                return ListTile(
                  onTap: () {
                    connectToDevice(device);
                  },
                  title: Text(device.name),
                  subtitle: Text(device.id.id),
                );
              } else {
                // İstenmeyen cihazları gösterme
                return Container(); // Boş bir widget döndürerek görünmez yapabilirsiniz
              }
            },
            separatorBuilder: (BuildContext context, int index) {
              return Divider();
            },
          )

      ),
      floatingActionButton: FloatingActionButton(
        onPressed: scan,
        child: Icon(_isScanning ? Icons.stop : Icons.search),
      ),
    );
  }
}
