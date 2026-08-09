import 'package:get_it/get_it.dart';

import '../features/calculator/data/datasources/calculator_remote_datasource.dart';
import '../features/calculator/data/repositories/calculator_repository_impl.dart';
import '../features/calculator/domain/repositories/calculator_repository.dart';
import '../features/calculator/domain/usecases/calculate_loan_usecase.dart';
import '../features/calculator/presentation/bloc/calculator_bloc.dart';

final GetIt sl = GetIt.instance;

void initCalculator() {
  // BLoC
  sl.registerFactory(() => CalculatorBloc(calculateLoanUseCase: sl()));

  // Use cases
  sl.registerLazySingleton(() => CalculateLoanUseCase(sl()));

  // Repository
  sl.registerLazySingleton<CalculatorRepository>(
    () => CalculatorRepositoryImpl(sl()),
  );

  // Data sources
  sl.registerLazySingleton<CalculatorRemoteDataSource>(
    () => CalculatorRemoteDataSourceImpl(sl()),
  );
}
