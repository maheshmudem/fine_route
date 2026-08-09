import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import '../../../../core/error/failures.dart';
import '../../../../core/usecase/usecase.dart';
import '../entities/loan_calculation.dart';
import '../repositories/calculator_repository.dart';

class CalculateLoanUseCase implements UseCase<LoanCalculation, CalculateLoanParams> {
  final CalculatorRepository repository;

  CalculateLoanUseCase(this.repository);

  @override
  Future<Either<Failure, LoanCalculation>> call(CalculateLoanParams params) async {
    return await repository.calculateLoan(
      amount: params.amount,
      interestRate: params.interestRate,
      interestType: params.interestType,
      frequency: params.frequency,
      duration: params.duration,
    );
  }
}

class CalculateLoanParams extends Equatable {
  final double amount;
  final double interestRate;
  final String interestType;
  final String frequency;
  final int duration;

  const CalculateLoanParams({
    required this.amount,
    required this.interestRate,
    required this.interestType,
    required this.frequency,
    required this.duration,
  });

  @override
  List<Object?> get props => [
        amount,
        interestRate,
        interestType,
        frequency,
        duration,
      ];
}
