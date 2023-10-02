/*
import 'dart:typed_data';
import 'package:flutter/material.dart';
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

  Future<void> sendBluetoothData(int data, BluetoothDevice device, String characteristicUuid) async {
    if (device.state == BluetoothDeviceState.connected) {
      try {
        final BluetoothCharacteristic? characteristic = await findCharacteristic(device, characteristicUuid);
        if (characteristic == null) {
          print('Hedef karakteristik bulunamadı');
          return;
        }

        // Int veriyi char veriye dönüştürme
        String charData = String.fromCharCode(data);

        // Veriyi String'den Uint8List'e dönüştürme
        Uint8List byteData = Uint8List.fromList(charData.codeUnits);

        await characteristic.write(byteData);

        print('Veri gönderildi: $charData');
      } catch (error) {
        print('Veri gönderme hatası: $error');
      }
    } else {
      print('Cihaz bağlı değil');
    }
  }


  Future<BluetoothCharacteristic?> findCharacteristic(BluetoothDevice device, String targetUuid) async {
    try {
      List<BluetoothService> services = await device.discoverServices();
      for (BluetoothService service in services) {
        for (BluetoothCharacteristic characteristic in service.characteristics) {
          if (characteristic.uuid.toString() == targetUuid) {
            return characteristic;
          }
        }
      }
    } catch (error) {
      print('Karakteristikleri bulma hatası: $error');
    }
    return null;
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
            ElevatedButton(
              onPressed: () {
                sendBluetoothData(1, widget.connectedDevice!, 'TARGET_CHARACTERISTIC_UUID');
              },
              child: Text("start"),
            ),
            ElevatedButton(
              onPressed: () {
                sendBluetoothData(0, widget.connectedDevice!, 'TARGET_CHARACTERISTIC_UUID');
              },
              child: Text("stop"),
            ),
            ElevatedButton(
              onPressed: () {
                sendBluetoothData(4, widget.connectedDevice!, 'TARGET_CHARACTERISTIC_UUID');
              },
              child: Text("10a"),
            ),
            ElevatedButton(
              onPressed: () {
                sendBluetoothData(3, widget.connectedDevice!, 'TARGET_CHARACTERISTIC_UUID');
              },
              child: Text("16a"),
            ),
            ElevatedButton(
              onPressed: () {
                sendBluetoothData(2, widget.connectedDevice!, 'TARGET_CHARACTERISTIC_UUID');
              },
              child: Text("32a"),
            ),
            ElevatedButton(
              onPressed: () {
                sendBluetoothData(1, widget.connectedDevice!, 'TARGET_CHARACTERISTIC_UUID');
              },
              child: Text("konf"),
            ),

          ],
        ),
      ),
    );
  }
}


 */