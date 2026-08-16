import 'package:get_it/get_it.dart';
import '../../core/network/api_client.dart';
import '../features/route_lines/data/datasources/route_lines_remote_data_source.dart';
import '../features/route_lines/data/repositories/route_lines_repository_impl.dart';
import '../features/route_lines/domain/repositories/route_lines_repository.dart';
import '../features/route_lines/presentation/bloc/create_route_line/create_route_line_bloc.dart';
import '../features/route_lines/presentation/bloc/route_lines/route_lines_bloc.dart';

final getIt = GetIt.instance;

void initRouteLines() {
  // Blocs
  getIt.registerFactory(() => RouteLinesBloc(repository: getIt()));
  getIt.registerFactory(() => CreateRouteLineBloc(repository: getIt()));

  // Repository
  getIt.registerLazySingleton<RouteLinesRepository>(
    () => RouteLinesRepositoryImpl(remoteDataSource: getIt()),
  );

  // Data sources
  getIt.registerLazySingleton<RouteLinesRemoteDataSource>(
    () => RouteLinesRemoteDataSourceImpl(apiClient: getIt<ApiClient>()),
  );
}
