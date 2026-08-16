import 'package:get_it/get_it.dart';
import '../features/activity/data/datasources/activity_remote_data_source.dart';
import '../features/activity/data/repositories/activity_repository_impl.dart';
import '../features/activity/domain/repositories/activity_repository.dart';
import '../features/activity/presentation/bloc/activity_bloc.dart';

final getIt = GetIt.instance;

void initActivity() {
  // Bloc
  getIt.registerFactory(() => ActivityBloc(repository: getIt()));

  // Repository
  getIt.registerLazySingleton<ActivityRepository>(
    () => ActivityRepositoryImpl(remoteDataSource: getIt()),
  );

  // Data sources
  getIt.registerLazySingleton<ActivityRemoteDataSource>(
    () => ActivityRemoteDataSourceImpl(apiClient: getIt()),
  );
}
