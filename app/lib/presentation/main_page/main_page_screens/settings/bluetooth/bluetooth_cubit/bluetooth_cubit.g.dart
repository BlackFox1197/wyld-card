// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'bluetooth_cubit.dart';

// **************************************************************************
// CopyWithGenerator
// **************************************************************************

abstract class _$BluetoothStateCWProxy {
  BluetoothState connectedDevices(List<BluetoothDevice> connectedDevices);

  BluetoothState devices(List<BluetoothDevice> devices);

  BluetoothState status(BStatus status);

  /// This function **does support** nullification of nullable fields. All `null` values passed to `non-nullable` fields will be ignored. You can also use `BluetoothState(...).copyWith.fieldName(...)` to override fields one at a time with nullification support.
  ///
  /// Usage
  /// ```dart
  /// BluetoothState(...).copyWith(id: 12, name: "My name")
  /// ````
  BluetoothState call({
    List<BluetoothDevice>? connectedDevices,
    List<BluetoothDevice>? devices,
    BStatus? status,
  });
}

/// Proxy class for `copyWith` functionality. This is a callable class and can be used as follows: `instanceOfBluetoothState.copyWith(...)`. Additionally contains functions for specific fields e.g. `instanceOfBluetoothState.copyWith.fieldName(...)`
class _$BluetoothStateCWProxyImpl implements _$BluetoothStateCWProxy {
  final BluetoothState _value;

  const _$BluetoothStateCWProxyImpl(this._value);

  @override
  BluetoothState connectedDevices(List<BluetoothDevice> connectedDevices) =>
      this(connectedDevices: connectedDevices);

  @override
  BluetoothState devices(List<BluetoothDevice> devices) =>
      this(devices: devices);

  @override
  BluetoothState status(BStatus status) => this(status: status);

  @override

  /// This function **does support** nullification of nullable fields. All `null` values passed to `non-nullable` fields will be ignored. You can also use `BluetoothState(...).copyWith.fieldName(...)` to override fields one at a time with nullification support.
  ///
  /// Usage
  /// ```dart
  /// BluetoothState(...).copyWith(id: 12, name: "My name")
  /// ````
  BluetoothState call({
    Object? connectedDevices = const $CopyWithPlaceholder(),
    Object? devices = const $CopyWithPlaceholder(),
    Object? status = const $CopyWithPlaceholder(),
  }) {
    return BluetoothState(
      connectedDevices: connectedDevices == const $CopyWithPlaceholder() ||
              connectedDevices == null
          ? _value.connectedDevices
          // ignore: cast_nullable_to_non_nullable
          : connectedDevices as List<BluetoothDevice>,
      devices: devices == const $CopyWithPlaceholder() || devices == null
          ? _value.devices
          // ignore: cast_nullable_to_non_nullable
          : devices as List<BluetoothDevice>,
      status: status == const $CopyWithPlaceholder() || status == null
          ? _value.status
          // ignore: cast_nullable_to_non_nullable
          : status as BStatus,
    );
  }
}

extension $BluetoothStateCopyWith on BluetoothState {
  /// Returns a callable class that can be used as follows: `instanceOfBluetoothState.copyWith(...)` or like so:`instanceOfBluetoothState.copyWith.fieldName(...)`.
  // ignore: library_private_types_in_public_api
  _$BluetoothStateCWProxy get copyWith => _$BluetoothStateCWProxyImpl(this);
}
