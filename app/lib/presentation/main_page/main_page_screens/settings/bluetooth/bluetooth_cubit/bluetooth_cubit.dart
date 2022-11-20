import 'package:bloc/bloc.dart';
import 'package:copy_with_extension/copy_with_extension.dart';
import 'package:flutter_blue_plus/flutter_blue_plus.dart';
import 'package:meta/meta.dart';

part 'bluetooth_cubit.g.dart';

part 'bluetooth_state.dart';

class BluetoothCubit extends Cubit<BluetoothState> {
  FlutterBluePlus flutterBlue = FlutterBluePlus.instance;
  BluetoothCubit() : super(BluetoothState.initial());


  void scanForDevices()async{
    flutterBlue.connectedDevices
        .asStream()
        .listen((List<BluetoothDevice> devices) {
            emit(state.copyWith(connectedDevices: devices));
    });

    emit(state.copyWith(status: BStatus.scanning));
    flutterBlue.startScan(timeout: Duration(seconds: 7)).then((value) => emit(state.copyWith(status: BStatus.scanned)));


    // Listen to scan results
    var subscription = flutterBlue.scanResults.listen((results) {
      //(results.where((element) => element.device.name != null)).map((e) => e.device).toList();
      emit(state.copyWith(devices: (results.where((element) => element.device.name != null && element.device.name !="")).map((e) => e.device).toList()));
      // do something with scan results
      // for (ScanResult r in results) {
      //   print('${r.device.name} found! rssi: ${r.rssi}');
      // }
    });


//     emit(state.copyWith(status: BStatus.scanning));
// // Start scanning
//     flutterBlue.scan(timeout: Duration(seconds: 4));
//
// // Listen to scan results
//     var subscription = flutterBlue.scanResults.listen((results) {
//       emit(state.copyWith(devices: results.map((e) => e.device).toList()));
//       // do something with scan results
//       for (ScanResult r in results) {
//         print('${r.device.name} found! rssi: ${r.rssi}');
//       }
//     });
    // Stop scanning
    //flutterBlue.stopScan().then((value) => emit(state.copyWith(status: BStatus.scanned)));
  }


  void connectToDevice(BluetoothDevice device) async{
    await device.connect();

  }

  void disconnect(BluetoothDevice device)async{
    await device.disconnect();
  }

  void scanServices(BluetoothDevice device)async{
    try{
      await device.connect();
    }catch (e){
    }
    List<BluetoothService> services = await device.discoverServices();
    services.forEach((service) async{
      print(service);
      var characteristics = service.characteristics;
      for(BluetoothCharacteristic c in characteristics.where((element) => element.properties.read))  {
        List<int> value = await c.read();
        print(value);
      }
    });
  }
}
