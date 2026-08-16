import 'package:get_it/get_it.dart';
import '../../core/network/api_client.dart';
import '../../features/expenses/data/datasources/expenses_remote_data_source.dart';
import '../../features/expenses/data/repositories/expenses_repository_impl.dart';
import '../../features/expenses/domain/repositories/expenses_repository.dart';
import '../../features/expenses/domain/usecases/expenses_usecases.dart';
import '../../features/expenses/presentation/bloc/expenses_bloc.dart';

final getIt = GetIt.instance;

void setupExpensesDI(GetIt getIt) {
  // Data sources
  getIt.registerLazySingleton<ExpensesRemoteDataSource>(
    () => ExpensesRemoteDataSourceImpl(getIt<ApiClient>()),
  );

  // Repository
  getIt.registerLazySingleton<ExpensesRepository>(
    () => ExpensesRepositoryImpl(getIt<ExpensesRemoteDataSource>()),
  );

  // Use cases
  getIt.registerLazySingleton(() => GetExpensesUseCase(getIt<ExpensesRepository>()));
  getIt.registerLazySingleton(() => GetExpenseCategoriesUseCase(getIt<ExpensesRepository>()));
  getIt.registerLazySingleton(() => GetPaymentModesUseCase(getIt<ExpensesRepository>()));
  getIt.registerLazySingleton(() => AddExpenseUseCase(getIt<ExpensesRepository>()));

  // Bloc
  getIt.registerFactory(
    () => ExpensesBloc(
      getExpensesUseCase: getIt<GetExpensesUseCase>(),
      getExpenseCategoriesUseCase: getIt<GetExpenseCategoriesUseCase>(),
      getPaymentModesUseCase: getIt<GetPaymentModesUseCase>(),
      addExpenseUseCase: getIt<AddExpenseUseCase>(),
    ),
  );
}
