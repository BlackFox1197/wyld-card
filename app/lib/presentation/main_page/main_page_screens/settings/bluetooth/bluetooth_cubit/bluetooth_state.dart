part of 'bluetooth_cubit.dart';

enum BStatus {scanning, scanned}
@CopyWith()
class BluetoothState {
  final BStatus status;
  final List<BluetoothDevice> devices;
  final List<BluetoothDevice> connectedDevices;

  BluetoothState({required this.status, this.devices = const [], this.connectedDevices = const []});

  factory BluetoothState.initial() => BluetoothState(status: BStatus.scanning);
}

