/*
import 'dart:convert';
import 'dart:typed_data';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_blue/flutter_blue.dart';

class Home extends StatefulWidget {
  final BluetoothDevice? connectedDevice;

  Home({Key? key, this.connectedDevice}) : super(key: key);

  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  List<double> parsedDataList = [];

  @override
  void initState() {
    super.initState();
    _startDataFetching();
  }

  // Bluetooth data fetching process
  void _startDataFetching() async {
    if (widget.connectedDevice != null) {
      try {
        // Discover the services of the connected device
        List<BluetoothService> services = await widget.connectedDevice!.discoverServices();
        for (BluetoothService service in services) {
          for (BluetoothCharacteristic characteristic in service.characteristics) {
            if (characteristic.properties.notify || characteristic.properties.indicate) {
              // Set up a subscription to listen for notifications or indications
              await characteristic.setNotifyValue(true);


              characteristic.value.listen((value) {
                // Handle incoming data here
                String receivedData = String.fromCharCodes(value);
                //print('Received data: $receivedData');

                // Parse and process the received data
                parseReceivedData(receivedData);
              });
            }
          }
        }
      } catch (e) {
        print('Veri alma hatası: $e');
      }
    }
  }

  void parseReceivedData(String receivedData) {
    List<String> parsedData = receivedData.split('#');
    List<double> doubleData = [];

    for (String data in parsedData) {
      List<String> numbers = data.split(RegExp(r'[^0-9.-]'));

      for (String number in numbers) {
        if (number.isNotEmpty) {
          double? parsedNumber = double.tryParse(number);
          if (parsedNumber != null) {
            doubleData.add(parsedNumber);
          }
        }
      }
    }

    if (doubleData.isNotEmpty) {
      // print('Temizlenmiş Veri: $doubleData');
      setState(() {
        parsedDataList = doubleData;
      });
    }
  }


  void goData(int value) async {
    if (widget.connectedDevice != null) {
      try {
        // Bağlı cihazın hizmetlerini keşfedin
        List<BluetoothService> services = await widget.connectedDevice!.discoverServices();

        // Tüm karakteristikleri tarayın ve yazma izni olanı bulun
        for (BluetoothService service in services) {
          var characteristics = service.characteristics;

          for (BluetoothCharacteristic c in characteristics) {
            // Karakteristiğin yazma özelliğini destekleyip desteklemediğini kontrol edin
            if (c.properties.write || c.properties.writeWithoutResponse) {
              // Veriyi doğru bir şekilde hazırlayın (Örneğin, 1 veya 2 gibi)
              String charData = value.toString();

              // Veriyi, yazma boyutu sınırına uyması için kısaltın
              charData = charData.substring(0, 16);

              // Veriyi Uint8List'e dönüştürün
              Uint8List data = Uint8List.fromList(charData.codeUnits);

              // Veriyi yazın
              await c.write(data);

              // Yazma işleminin başarılı olduğunu kontrol etmek için bir bekleme süresi ekleyebilirsiniz
              await Future.delayed(Duration(seconds: 1));

              // Yazma işleminin başarılı olduğunu kontrol edin
              // Burada özel bir geri bildirim yoksa, yazma işlemi başarılı sayılabilir
              print("Veri başarılı bir şekilde yazıldı: $data");

              // Yazma işlemi yaptığımız karakteristiği bulduğumuza göre döngüyü sonlandırabiliriz
              return;
            }
          }
        }

        // Yazma izni veren karakteristik bulunamadıysa bir hata mesajı görüntüleyin
        print("Yazma izni veren karakteristik bulunamadı.");
      } catch (e) {
        // Yazma hatasını işleyin
        if (e is PlatformException && e.code == 'write_characteristic_error') {
          print('Write characteristic failed: ${e.message}');
        } else {
          print("Veri alma hatası: $e");
        }
      }
    }
  }



  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Bluetooth Veri Gösterimi"),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text(
              "Bağlı Cihaz: ${widget.connectedDevice?.name ?? 'Bağlı Cihaz Yok'}",
              style: TextStyle(fontSize: 18),
            ),
            SizedBox(height: 20),
            for (int i = 0; i < parsedDataList.length; i++)
              Text(
                "Veri $i: ${parsedDataList[i]}",
                style: TextStyle(fontSize: 18),
              ),
            ElevatedButton(onPressed: () {
              goData(1);
            }, child: Text("start")),
            ElevatedButton(onPressed: () {
              goData(2);
            }, child: Text("stop")),
          ],
        ),
      ),
    );
  }
}


 */