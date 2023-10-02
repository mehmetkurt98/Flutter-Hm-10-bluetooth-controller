
/*
import 'package:flutter/material.dart';
import 'package:flutter_blue/flutter_blue.dart';
import 'package:permission_handler/permission_handler.dart';
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

  @override
  void initState() {
    super.initState();


    // Bluetooth cihazı taranmadığında varsayılan olarak taranmadığı kabul edilir.
    _isScanning = false;
  }

  /*
  BLE tarayıcısını başlat veya durdur
  */
  Future<void> scan() async {


    Map<Permission, PermissionStatus> statuses = await [Permission.bluetoothScan, Permission.bluetoothAdvertise,Permission.bluetoothConnect].request();

    if (statuses[Permission.bluetoothScan] == PermissionStatus.granted && statuses[Permission.bluetoothScan] == PermissionStatus.granted) {

      if (!_isScanning) {
        // Tarayıcı çalışmıyorsa
        // Daha önce tarama sonuçlarını temizle
        scanResultList.clear();
        // Taramayı başlat, 4 saniye süreyle sınırla
        flutterBlue.startScan(timeout: Duration(seconds: 4));
        // Tarama sonuçlarını dinle
        flutterBlue.scanResults.listen((results) {
          // List<ScanResult> türündeki sonuçları scanResultList'e kopyala
          setState(() {
            scanResultList = results;
          });
        });
      } else {
        // Tarama yapılıyorsa taramayı durdurddddddds
        flutterBlue.stopScan();
      }

      // Tarama durumu güncelle
      setState(() {
        _isScanning = !_isScanning;
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
        /* Cihaz listesini göster */
        child: ListView.separated(
          itemCount: scanResultList.length,
          itemBuilder: (context, index) {
            return listItem(scanResultList[index]);
          },
          separatorBuilder: (BuildContext context, int index) {
            return Divider();
          },
        ),
      ),
      /* Taramayı başlat veya durdur düğmesi */
      floatingActionButton: FloatingActionButton(
        onPressed: scan,
        // Tarama sırasında durdurma ikonunu, durduğunda başlatma ikonunu göster
        child: Icon(_isScanning ? Icons.stop : Icons.search),
      ),
    );
  }

  /*  Cihazın sinyal gücü widget'i  */
  Widget deviceSignal(ScanResult r) {
    return Text(r.rssi.toString());
  }

  /* Cihazın MAC adresi widget'i  */
  Widget deviceMacAddress(ScanResult r) {
    return Text(r.device.id.id);
  }

  /* Cihazın adı widget'i  */
  Widget deviceName(ScanResult r) {
    String name = '';

    if (r.device.name.isNotEmpty) {
      // Cihazın adı varsa
      name = r.device.name;
    } else if (r.advertisementData.localName.isNotEmpty) {
      // advertisementData.localName değeri varsa
      name = r.advertisementData.localName;
    } else {
      // Hiçbiri yoksa adı bilinmiyor...
      name = 'N/A';
    }
    return Text(name);
  }

  /* BLE simgesi widget'i */
  Widget leading(ScanResult r) {
    return CircleAvatar(
      child: Icon(
        Icons.bluetooth,
        color: Colors.white,
      ),
      backgroundColor: Colors.cyan,
    );
  }

  /* Cihaz öğesine tıklandığında çağrılan işlev */
  void onTap(ScanResult r) {
    // Sadece adı yazdır
    print('${r.device.name}');
  }

  /* Cihaz öğesi widget'i */
  Widget listItem(ScanResult r) {
    return ListTile(
      onTap: () => onTap(r),
      leading: leading(r),
      title: deviceName(r),
      subtitle: deviceMacAddress(r),
      trailing: deviceSignal(r),
    );
  }
}


 */