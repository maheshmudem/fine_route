import '../core/network/api_client.dart';
import '../features/dashboard/data/datasources/dashboard_remote_data_source.dart';
import '../features/dashboard/data/repositories/dashboard_repository_impl.dart';
import '../features/dashboard/domain/repositories/dashboard_repository.dart';
import '../features/dashboard/domain/usecases/get_dashboard_data_usecase.dart';
import '../features/dashboard/domain/usecases/get_weekly_summary_usecase.dart';
import '../features/dashboard/presentation/bloc/dashboard_bloc.dart';
import 'expenses_di.dart';

void initDashboard() {
  // Bloc
  getIt.registerFactory(
    () => DashboardBloc(
      getDashboardData: getIt(),
      getWeeklySummary: getIt(),
    ),
  );

  // Use cases
  getIt.registerLazySingleton(() => GetDashboardDataUseCase(getIt()));
  getIt.registerLazySingleton(() => GetWeeklySummaryUseCase(getIt()));

  // Repository
  getIt.registerLazySingleton<DashboardRepository>(
    () => DashboardRepositoryImpl(getIt()),
  );

  // Data sources
  getIt.registerLazySingleton<DashboardRemoteDataSource>(
    () => DashboardRemoteDataSourceImpl(getIt<ApiClient>()),
  );
}
