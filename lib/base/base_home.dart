/*
import 'dart:typed_data';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_blue/flutter_blue.dart';

import '../utils/bluetooth_singleton.dart';

class Home extends StatefulWidget {
  BluetoothDevice? selectedDevice = BluetoothManager().selectedDevice;


  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  Color myColor = Color(0xFF063A34);
  Color soketColor = Color(0xFF03DABB);
  Color redColor =Color(0xFF0EF0909);
  Color dfcBackGround=Color(0xFF000FFDA);
  Color celciusBackGround = Color(0xFF0182724);
  Color dereceTextBackGround =Color(0xFF0CD3939);
  Color amperBackGround = Color(0xFF0182724);
  Color buttonBackground =Color(0xFF00CE8A6);
  Color startColor =Color(0xFF000FFDA);
  List<double> parsedDataList = [];

  @override
  void initState() {
    super.initState();
    _startDataFetching();
  }

  // Bluetooth data fetching process
  Future _startDataFetching() async {
    if (widget.selectedDevice != null) {
      try {
        // Discover the services of the connected device
        List<BluetoothService> services = await widget.selectedDevice!.discoverServices();
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

  Future parseReceivedData(String receivedData) async {
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

  Future goData(String value) async {

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
              return;
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

  @override
  Widget build(BuildContext context) {
    void _showAlertDialog(BuildContext context) {
      showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: Text("Akım Seç"), // Alert dialog başlığı
            content: Container(
              width: MediaQuery.of(context).size.width * 0.8, // Genişliği artırabilirsiniz
              child: Column(
                mainAxisSize: MainAxisSize.min, // İçeriği minimum boyuta sığdır
                crossAxisAlignment: CrossAxisAlignment.start, // İçeriği sola hizala
                children: [
                  Text("Akım seçtikten sonra Konfigure et butonuna basmalısınız."), // Alert dialog içeriği
                  SizedBox(height: 10),
                  TextButton(
                    onPressed: () {
                      goData("2");
                      // Bir şey yap
                    },
                    child: Text("32A"),
                  ),
                  TextButton(
                    onPressed: () {
                      goData("3");
                      // Başka bir şey yap
                    },
                    child: Text("16A"),
                  ),
                  TextButton(
                    onPressed: () {
                      goData("4");
                      // Başka bir şey yap
                    },
                    child: Text("10A"),
                  ),
                  TextButton(
                    onPressed: () {
                      goData("5");
                      // Başka bir şey yap
                    },
                    child: Text("8A"),
                  ),
                  TextButton(
                    onPressed: () {
                      goData("9");
                      // Başka bir şey yap
                      Navigator.of(context).pop(); // Alert dialog'u kapat
                    },
                    child: Text("Configure Et"),
                  ),
                ],
              ),
            ),
          );
        },
      );
    }

    return Scaffold(
      backgroundColor: Colors.black,
      body: SingleChildScrollView(
        child: Column(
          children: [

            SizedBox(height: 80),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 24.0),
              child: SizedBox(
                height: MediaQuery.of(context).size.height / 5,
                width: MediaQuery.of(context).size.width / 1.06,
                child: Card(
                  color: myColor,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Row(
                        children: [
                          SizedBox(width: 60),
                          Icon(Icons.info_outline, color: Colors.grey),
                          SizedBox(width: 8, height: 40),
                          Expanded(
                            child: Text(
                              '${parsedDataList.isNotEmpty ? (parsedDataList[0] == 5 ? 'Başlat Komutu Bekleniyor' : (parsedDataList[0] == 9 ? 'Şarja Hazır' : (parsedDataList[0] == 6 ? 'Araç Şarj Oluyor' : 'Soket Bağlı Değil'))) : 'Veri Yok'}',
                              style: TextStyle(
                                fontSize: 18,
                                fontWeight: FontWeight.bold,
                                color: Colors.white,
                              ),
                              overflow: TextOverflow.ellipsis,
                              maxLines: 2,
                            ),
                          ),
                        ],
                      ),
                      SizedBox(height: 8), // İki metin arasında boşluk ekleyin
                      Text(
                        parsedDataList.isNotEmpty && parsedDataList[0] == 12 && parsedDataList[0] != 6 && parsedDataList[0] != 9 && parsedDataList[0] != 5
                            ? 'Lütfen Soketi Bağlayınız'
                            : '',
                        style: TextStyle(color: redColor, fontSize: 14),
                      ),
                    ],
                  ),
                ),
              ),
            ),

            SizedBox(height: 100,),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                SizedBox(
                  height: MediaQuery.of(context).size.height/4.5,
                  width: MediaQuery.of(context).size.width/2.1,
                  child: Card(
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10.0),
                    ),
                    color: dfcBackGround,
                    child: Row(
                      children: [
                        Flexible(
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Text('${parsedDataList.isNotEmpty ? (parsedDataList[1] == 2 ? 'GFCI Başarılı' : (parsedDataList[1] == 1 ? 'GFCI Başarısız' : 'Veri Yok')) : 'Veri Yok'}', // GFCI durumu metni
                              style: TextStyle(
                                fontSize: 20,
                                color: Colors.white,
                                fontWeight: FontWeight.bold,
                              ),
                              overflow: TextOverflow.ellipsis,
                              maxLines: 2,
                            ),
                          ),
                        ),
                        SizedBox(
                          width: 26,
                          height: 40,
                          child: Icon(
                            Icons.check_circle,
                            color: Colors.white,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                SizedBox(
                  height: MediaQuery.of(context).size.height/4.5,
                  width: MediaQuery.of(context).size.width/2.1,
                  child: Card(
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10.0), // Kenarları yuvarlamak için BorderRadius.circular kullanılır
                    ),
                    color: celciusBackGround,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(Icons.device_thermostat_outlined,color: dereceTextBackGround,),
                        Text('${parsedDataList.isNotEmpty ? parsedDataList[3].toString() : 'Veri yok'}${parsedDataList.isNotEmpty ? '°C' : ''}',style: TextStyle(color: dereceTextBackGround,fontSize: MediaQuery.of(context).size.width/15,),overflow: TextOverflow.ellipsis,
                          maxLines: 2,),

                      ],
                    ),
                  ),
                ),
              ],
            ),
            SizedBox(
              height: MediaQuery.of(context).size.height/6,
              width: MediaQuery.of(context).size.width/1,
              child: GestureDetector(
                onTap: (){
                  _showAlertDialog(context);

                },
                child: Card(
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10.0), // Kenarları yuvarlamak için BorderRadius.circular kullanılır
                  ),
                  color: amperBackGround,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          SizedBox(height: 10,),
                          Text("Akım",style: TextStyle(color: Colors.white,fontWeight: FontWeight.bold,fontSize: 18),overflow: TextOverflow.ellipsis,
                            maxLines: 2,),

                        ],
                      ),
                      SizedBox(width: 10,),
                      Text('${parsedDataList.isNotEmpty ? (parsedDataList[2] == 350 ? '32 A 7,4 kW' : (parsedDataList[2] == 650 ? '16 A 3,7 kW' :(parsedDataList[2] == 770 ? '10 A 2,3 kW' : (parsedDataList[2] == 800 ? '8        '
                          ' A 1,8 kW' :'Veri Yok')))) : 'Veri Yok '}  ',style: TextStyle(color: Colors.white,fontSize: 15,fontWeight: FontWeight.bold),overflow: TextOverflow.ellipsis,
                        maxLines: 2,),
                      SizedBox(
                          height: 200,
                          width: 200,
                          child: Image.asset("assets/vector.png")),
                    ],
                  ),
                ),
              ),
            ),
            Row(
              children: [
                InkWell(
                  onTap: () {
                    goData("0");
                  },
                  child: Container(
                    padding: EdgeInsets.only(right: 5), // İmgenin etrafında boşluk ekleyin
                    child: Image.asset("assets/start-new.png"),
                  ),
                ),
                InkWell(
                  onTap: () {
                    goData("1");
                  },
                  child: Container(
                    padding: EdgeInsets.only(left: 5), // İmgenin etrafında boşluk ekleyin
                    child: Image.asset("assets/stop-new.png"),
                  ),
                ),
              ],
            ),

            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [

                ElevatedButton(onPressed: (){
                  goData("8");
                }, child: Text("Resetle")),
              ],
            )

          ],
        ),
      ),
    );
  }
}

 */