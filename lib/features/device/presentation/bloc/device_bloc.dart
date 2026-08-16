import 'package:flutter_bloc/flutter_bloc.dart';
import '../../domain/repositories/device_repository.dart';
import 'device_event.dart';
import 'device_state.dart';

class DeviceBloc extends Bloc<DeviceEvent, DeviceState> {
  final DeviceRepository repository;

  DeviceBloc({required this.repository}) : super(DeviceInitial()) {
    on<LoadDevicesEvent>(_onLoadDevices);
    on<RevokeDeviceEvent>(_onRevokeDevice);
  }

  Future<void> _onLoadDevices(LoadDevicesEvent event, Emitter<DeviceState> emit) async {
    emit(DeviceLoading());

    final result = await repository.getSessions(page: 1, pageSize: 100);

    result.fold(
      (failure) => emit(DeviceError(message: failure.message)),
      (devices) => emit(DeviceLoaded(devices: devices)),
    );
  }

  Future<void> _onRevokeDevice(RevokeDeviceEvent event, Emitter<DeviceState> emit) async {
    if (state is DeviceLoaded) {
      final currentDevices = (state as DeviceLoaded).devices;
      emit(DeviceActionLoading(devices: currentDevices));

      final result = await repository.revokeSession(event.id);

      result.fold(
        (failure) {
          emit(DeviceError(message: failure.message));
          emit(DeviceLoaded(devices: currentDevices)); // Restore list on error
        },
        (_) {
          final newDevices = currentDevices.where((d) => d.id != event.id).toList();
          emit(DeviceActionSuccess(devices: newDevices));
          emit(DeviceLoaded(devices: newDevices));
        },
      );
    }
  }
}
