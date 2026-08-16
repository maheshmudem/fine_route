import 'package:get_it/get_it.dart';
import '../features/session/data/datasources/session_remote_data_source.dart';
import '../features/session/data/repositories/session_repository_impl.dart';
import '../features/session/domain/repositories/session_repository.dart';
import '../features/session/presentation/bloc/session_bloc.dart';

final getIt = GetIt.instance;

void initSession() {
  // Bloc
  getIt.registerFactory(() => SessionBloc(repository: getIt()));

  // Repository
  getIt.registerLazySingleton<SessionRepository>(
    () => SessionRepositoryImpl(remoteDataSource: getIt()),
  );

  // Data sources
  getIt.registerLazySingleton<SessionRemoteDataSource>(
    () => SessionRemoteDataSourceImpl(apiClient: getIt()),
  );
}
