import 'package:flutter_blue/flutter_blue.dart';

class BluetoothManager {
  BluetoothDevice? _selectedDevice; // BluetoothDevice türünde nullable değişken
  static final BluetoothManager _instance = BluetoothManager._internal();

  factory BluetoothManager() {
    return _instance;
  }

  BluetoothManager._internal() {
    _selectedDevice = null; // Başlangıçta null değeri ile başlatılıyor
  }

  BluetoothDevice? get selectedDevice => _selectedDevice;

  set selectedDevice(BluetoothDevice? device) { // BluetoothDevice? türünü kullanarak uyumlu hale getirin
    _selectedDevice = device;
  }
}
