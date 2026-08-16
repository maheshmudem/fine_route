import 'package:get_it/get_it.dart';
import '../core/network/api_client.dart';
import '../features/profile/data/datasources/profile_remote_data_source.dart';
import '../features/profile/domain/repositories/profile_repository.dart';
import '../features/profile/data/repositories/profile_repository_impl.dart';
import '../features/profile/domain/usecases/get_profile_usecase.dart';
import '../features/profile/presentation/bloc/profile_bloc.dart';

import '../features/profile/domain/usecases/update_profile_usecase.dart';

void setupProfileDI(GetIt getIt) {
  getIt.registerLazySingleton<ProfileRemoteDataSource>(
    () => ProfileRemoteDataSourceImpl(apiClient: getIt<ApiClient>()),
  );
  getIt.registerLazySingleton<ProfileRepository>(
    () => ProfileRepositoryImpl(remoteDataSource: getIt<ProfileRemoteDataSource>()),
  );
  getIt.registerLazySingleton<GetProfileUseCase>(
    () => GetProfileUseCase(getIt<ProfileRepository>()),
  );
  getIt.registerLazySingleton<UpdateProfileUseCase>(
    () => UpdateProfileUseCase(getIt<ProfileRepository>()),
  );
  getIt.registerFactory<ProfileBloc>(
    () => ProfileBloc(
      getProfileUseCase: getIt<GetProfileUseCase>(),
      updateProfileUseCase: getIt<UpdateProfileUseCase>(),
    ),
  );
}
