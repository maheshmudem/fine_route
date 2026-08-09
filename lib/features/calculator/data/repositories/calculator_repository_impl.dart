import 'package:dartz/dartz.dart';
import '../../../../core/error/failures.dart';
import '../../domain/entities/loan_calculation.dart';
import '../../domain/repositories/calculator_repository.dart';
import '../datasources/calculator_remote_datasource.dart';

class CalculatorRepositoryImpl implements CalculatorRepository {
  final CalculatorRemoteDataSource remoteDataSource;

  CalculatorRepositoryImpl(this.remoteDataSource);

  @override
  Future<Either<Failure, LoanCalculation>> calculateLoan({
    required double amount,
    required double interestRate,
    required String interestType,
    required String frequency,
    required int duration,
  }) async {
    try {
      final payload = {
        'amount': double.parse(amount.toStringAsFixed(2)),
        'interest_rate': double.parse(interestRate.toStringAsFixed(2)),
        'interest_type': interestType,
        'frequency': frequency,
        'duration': duration,
      };
      
      final result = await remoteDataSource.calculateLoan(payload);
      return Right(result);
    } catch (e) {
      return Left(ServerFailure(message: e.toString()));
    }
  }
}
