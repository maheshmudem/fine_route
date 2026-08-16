import 'package:get_it/get_it.dart';
import '../features/device/data/datasources/device_remote_data_source.dart';
import '../features/device/data/repositories/device_repository_impl.dart';
import '../features/device/domain/repositories/device_repository.dart';
import '../features/device/presentation/bloc/device_bloc.dart';

final getIt = GetIt.instance;

void initDevice() {
  // Bloc
  getIt.registerFactory(() => DeviceBloc(repository: getIt()));

  // Repository
  getIt.registerLazySingleton<DeviceRepository>(
    () => DeviceRepositoryImpl(remoteDataSource: getIt()),
  );

  // Data sources
  getIt.registerLazySingleton<DeviceRemoteDataSource>(
    () => DeviceRemoteDataSourceImpl(apiClient: getIt()),
  );
}
