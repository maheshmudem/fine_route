import 'package:equatable/equatable.dart';

abstract class DeviceEvent extends Equatable {
  const DeviceEvent();

  @override
  List<Object?> get props => [];
}

class LoadDevicesEvent extends DeviceEvent {}

class RevokeDeviceEvent extends DeviceEvent {
  final int id;

  const RevokeDeviceEvent(this.id);

  @override
  List<Object?> get props => [id];
}
