import 'dart:typed_data';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_blue/flutter_blue.dart';

import '../utils/bluetooth_singleton.dart';



class AmperPage extends StatefulWidget {
  BluetoothDevice? selectedDevice = BluetoothManager().selectedDevice;



  @override
  _AmperPageState createState() => _AmperPageState();
}

class _AmperPageState extends State<AmperPage> {


  Future goData(String value) async {
    print(widget.selectedDevice.toString());

    if (widget.selectedDevice != null) {
      try {
        // Bağlı cihazın hizmetlerini keşfedin
        List<BluetoothService> services = await widget.selectedDevice!.discoverServices();

        // Tüm karakteristikleri tarayın ve yazma izni olanı bulun
        for (BluetoothService service in services) {

          if (service.uuid.toString() == "0000ffe0-0000-1000-8000-00805f9b34fb") {
            var characteristics = service.characteristics;

            for (BluetoothCharacteristic c in characteristics) {
              // Karakteristiğin yazma özelliğini destekleyip desteklemediğini kontrol edin
              if (c.properties.write || c.properties.writeWithoutResponse) {
                // Veriyi doğru bir şekilde hazırlayın
                String charData = value;

                // Veriyi Uint8List'e dönüştürün
                Uint8List data = Uint8List.fromList(charData.codeUnits);

                // Veriyi yazın
                await c.write(data);

                // Yazma işleminin başarılı olduğunu kontrol etmek için bir bekleme süresi ekleyebilirsiniz
                //await Future.delayed(Duration(seconds: 1));

                // Yazma işleminin başarılı olduğunu kontrol edin
                // Burada özel bir geri bildirim yoksa, yazma işlemi başarılı sayılabilir
                print("Veri başarılı bir şekilde yazıldı: $data");

                // Yazma işlemi yaptığımız karakteristiği bulduğumuza göre döngüyü sonlandırabiliriz
              }
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

  int _type = 1;
  String _currentAmpere = '32';

  void _switchType(int type) {
    setState(() {
      _type = type;
      // Type'e göre akımı güncelle
      if (_type == 1) {
        _currentAmpere = '32';
      } else if (_type == 2) {
        _currentAmpere = '16';
      } else if (_type == 3) {
        _currentAmpere = '10';
      } else if (_type == 4) {
        _currentAmpere = '8';
      }
    });
  }

  void _configure() {
    // Konfigure Et butonuna basıldığında doğru veriyi göndermek için işlem yapın
    if (_type == 1) {
      goData('2');
    } else if (_type == 2) {
      goData('3');
    } else if (_type == 3) {
      goData('4');
    } else if (_type == 4) {
      goData('5');
    }
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        backgroundColor: Colors.black,
        body: Center(
          child: Container(
            width: 350,
            height: 400,
            child: Card(
              color: Colors.blue,
              elevation: 5,
              child: Container(
                padding: EdgeInsets.all(20),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    GestureDetector(
                      onTap: () {
                        if (_type > 1) {
                          _switchType(_type - 1);
                        }
                      },
                      child: CustomPaint(
                        size: Size(25, 25),
                        painter: TrianglePainter(upward: true),
                      ),
                    ),
                    SizedBox(height: 25,),

                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        SizedBox(width: 55),
                        Text(
                          'Type $_type',
                          style: TextStyle(fontSize: 24, color: Colors.black, fontWeight: FontWeight.bold),
                        ),
                        SizedBox(width: 8),
                        Column(
                          children: [
                            Text(
                              '$_currentAmpere',
                              style: TextStyle(fontSize: 24, color: Colors.black, fontWeight: FontWeight.bold),
                            ),
                            Text(
                              'Amper',
                              style: TextStyle(fontSize: 16, color: Colors.black),
                            ),
                          ],
                        )
                      ],
                    ),
                    SizedBox(height: 25,),

                    GestureDetector(
                      onTap: () {
                        if (_type < 4) {
                          _switchType(_type + 1);
                        }
                      },
                      child: CustomPaint(
                        size: Size(25, 25),
                        painter: TrianglePainter(upward: false),
                      ),
                    ),
                    SizedBox(
                        height: 50,
                        width: 187,
                        child: Image.asset("assets/vector.png")),
                    ElevatedButton(
                      onPressed: (){
                        _configure();
                        goData("9");
                      }, // Konfigure Et butonuna tıklandığında _configure fonksiyonu çağrılır
                      child: Text("Konfigure Et"),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class TrianglePainter extends CustomPainter {
  final bool upward;

  TrianglePainter({required this.upward});

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = Color(0xFF05DBF2)
      ..style = PaintingStyle.fill;

    final path = Path();
    if (upward) {
      path.moveTo(size.width / 2, 0);
      path.lineTo(size.width, size.height);
      path.lineTo(0, size.height);
    } else {
      path.moveTo(0, 0);
      path.lineTo(size.width, 0);
      path.lineTo(size.width / 2, size.height);
    }
    path.close();

    canvas.drawPath(path, paint);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return false;
  }
}
