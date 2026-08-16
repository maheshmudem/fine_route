import 'package:get_it/get_it.dart';
import '../core/network/api_client.dart';
import '../features/business/data/datasources/business_remote_data_source.dart';
import '../features/business/data/repositories/business_repository_impl.dart';
import '../features/business/domain/repositories/business_repository.dart';
import '../features/business/domain/usecases/get_business_usecase.dart';
import '../features/business/domain/usecases/update_business_usecase.dart';
import '../features/business/presentation/bloc/business_bloc.dart';

void setupBusinessDI(GetIt getIt) {
  getIt.registerLazySingleton<BusinessRemoteDataSource>(
    () => BusinessRemoteDataSourceImpl(apiClient: getIt<ApiClient>()),
  );
  getIt.registerLazySingleton<BusinessRepository>(
    () => BusinessRepositoryImpl(remoteDataSource: getIt<BusinessRemoteDataSource>()),
  );
  getIt.registerLazySingleton<GetBusinessUseCase>(
    () => GetBusinessUseCase(getIt<BusinessRepository>()),
  );
  getIt.registerLazySingleton<UpdateBusinessUseCase>(
    () => UpdateBusinessUseCase(getIt<BusinessRepository>()),
  );
  getIt.registerFactory<BusinessBloc>(
    () => BusinessBloc(
      getBusinessUseCase: getIt<GetBusinessUseCase>(),
      updateBusinessUseCase: getIt<UpdateBusinessUseCase>(),
    ),
  );
}
