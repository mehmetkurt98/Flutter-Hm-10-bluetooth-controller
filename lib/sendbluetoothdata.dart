/*
Future<void> sendBluetoothData(BluetoothDevice connectedDevice, int data) async {
  if (connectedDevice != null) {
    final BluetoothDevice device = connectedDevice;
    if (device.state == BluetoothDeviceState.connected) {
      try {
        // Veriyi karaktere çevir
        String charData = String.fromCharCode(data);

        // Veriyi UTF-8 kodlamasına dönüştür
        Uint8List byteData = Uint8List.fromList(utf8.encode(charData));

        // Hedef karakteristiği bul
        final BluetoothCharacteristic? characteristic = await findCharacteristic(device, sonc!);

        if (characteristic == null) {
          print('Hedef karakteristik bulunamadı');
          return;
        }

        // Veriyi yaz
        await characteristic.write(byteData);

        print('Veri gönderildi: $charData');
      } catch (error) {
        print('Veri gönderme hatası: $error');
      }
    } else {
      print('Cihaz bağlı değil');
    }
  } else {
    print('Cihaz seçilmedi');
  }
}
String? sonc;

Future<BluetoothCharacteristic?> findCharacteristic(BluetoothDevice device, String targetCharacteristicUUID) async {
  try {
    List<BluetoothService> services = await device.discoverServices();
    for (BluetoothService service in services) {
      for (BluetoothCharacteristic characteristic in service.characteristics) {
        if (characteristic.uuid.toString() == targetCharacteristicUUID) {
          sonc= characteristic.toString();
        }
      }
    }
  } catch (error) {
    print('Karakteristik bulma hatası: $error');
  }
  return null;
}




 */