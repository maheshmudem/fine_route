import 'package:equatable/equatable.dart';
import '../../domain/entities/device_session.dart';

abstract class DeviceState extends Equatable {
  const DeviceState();

  @override
  List<Object?> get props => [];
}

class DeviceInitial extends DeviceState {}

class DeviceLoading extends DeviceState {}

class DeviceLoaded extends DeviceState {
  final List<DeviceSession> devices;

  const DeviceLoaded({required this.devices});

  @override
  List<Object?> get props => [devices];
}

class DeviceError extends DeviceState {
  final String message;

  const DeviceError({required this.message});

  @override
  List<Object?> get props => [message];
}

class DeviceActionLoading extends DeviceLoaded {
  const DeviceActionLoading({required super.devices});
}

class DeviceActionSuccess extends DeviceLoaded {
  const DeviceActionSuccess({required super.devices});
}
