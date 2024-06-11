import 'package:flutter/material.dart';
import 'package:flutter_blue/flutter_blue.dart';

class BluetoothScreen extends StatefulWidget {
  @override
  _BluetoothScreenState createState() => _BluetoothScreenState();
}

class _BluetoothScreenState extends State<BluetoothScreen> {
  FlutterBlue flutterBlue = FlutterBlue.instance;
  BluetoothDevice? connectedDevice;

  @override
  void initState() {
    super.initState();
    flutterBlue.state.listen((state) {
      if (state == BluetoothState.on) {
        _getConnectedDevice();
      }
    });
    flutterBlue.connectedDevices.asStream().listen((devices) {
      for (BluetoothDevice device in devices) {
        print('Connected Device: ${device.name}');
      }
    });
  }

  Future<void> _getConnectedDevice() async {
    List<BluetoothDevice> devices = await flutterBlue.connectedDevices;
    if (devices.isNotEmpty) {
      setState(() {
        connectedDevice = devices.first;
      });
      print("devices : ${connectedDevice!.name}");
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Center(
        child: Text(
          connectedDevice != null
              ? 'Connected to: ${connectedDevice!.name}'
              : 'No connected device',
          style: TextStyle(
            color: connectedDevice != null ? Colors.green : Colors.red,
          ),
        ),
      ),
    );
  }
}
