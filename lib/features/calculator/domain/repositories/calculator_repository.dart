import 'package:dartz/dartz.dart';
import '../../../../core/error/failures.dart';
import '../entities/loan_calculation.dart';

abstract class CalculatorRepository {
  Future<Either<Failure, LoanCalculation>> calculateLoan({
    required double amount,
    required double interestRate,
    required String interestType,
    required String frequency,
    required int duration,
  });
}
