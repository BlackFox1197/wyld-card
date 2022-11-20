import 'package:flutter/material.dart';
import 'package:flutter_blue_plus/flutter_blue_plus.dart';

class BTOV extends StatefulWidget {



  const BTOV({Key? key}) : super(key: key);

  @override
  State<BTOV> createState() => _BTOVState();
}

class _BTOVState extends State<BTOV> {



  final FlutterBluePlus flutterBlue =  FlutterBluePlus.instance;

  final List<BluetoothDevice> devicesList = <BluetoothDevice>[];


  @override
  void initState() {

    flutterBlue.startScan(timeout: Duration(seconds: 4));

// Listen to scan results
    var subscription = flutterBlue.scanResults.listen((results) {
      // do something with scan results
      for (ScanResult r in results) {
        print('${r.device.name} found! rssi: ${r.rssi}');
      }
    });

// Stop scanning
//    flutterBlue.stopScan();
//     super.initState();
//     flutterBlue.startScan();
//     // var scanSubscription = flutterBlue.scan().listen((scanResult) async {
//     //   print(scanResult);
//     //   if (scanResult.device.name == "your_device_name") {print("found device");
//     //       BluetoothDevice device = scanResult.device;
//     //   }
//     // }
//     // );
//     flutterBlue.connectedDevices
//         .asStream()
//         .listen((List<BluetoothDevice> devices) {
//       for (BluetoothDevice device in devices) {
//         print(device);
//         _addDeviceTolist(device);
//       }
//     });
//     flutterBlue.scanResults.listen((List<ScanResult> results) {
//       for (ScanResult result in results) {
//         print(result);
//         _addDeviceTolist(result.device);
//       }
//     });
//     flutterBlue.startScan();

  }


    // flutterBlue.connectedDevices
    //     .asStream()
    //     .listen((List<BluetoothDevice> devices) {
    //   for (BluetoothDevice device in devices) {
    //     print(device);
    //     _addDeviceTolist(device);
    //   }
    // });
    // flutterBlue.scanResults.listen((List<ScanResult> results) {
    //   for (ScanResult result in results) {
    //     print(result);
    //     _addDeviceTolist(result.device);
    //   }
    // });
    // flutterBlue.startScan();

  @override
  Widget build(BuildContext context) {
    return Expanded(child: _buildListViewOfDevices());
  }




  ListView _buildListViewOfDevices() {
    List<Container> containers = <Container>[];
    for (BluetoothDevice device in devicesList) {
      containers.add(
        Container(
          height: 50,
          child: Row(
            children: <Widget>[
              Expanded(
                child: Column(
                  children: <Widget>[
                    Text(device.name == '' ? '(unknown device)' : device.name),
                    Text(device.id.toString()),
                  ],
                ),
              ),
              MaterialButton(
                color: Colors.blue,
                child: Text(
                  'Connect',
                  style: TextStyle(color: Colors.white),
                ),
                onPressed: () {},
              ),
            ],
          ),
        ),
      );
    }

    return ListView(
      padding: const EdgeInsets.all(8),
      children: <Widget>[
        ...containers,
      ],
    );
  }



  _addDeviceTolist(final BluetoothDevice device) {
    if (devicesList.contains(device)) {
      setState(() {devicesList.add(device);
      });
    }
  }
}
