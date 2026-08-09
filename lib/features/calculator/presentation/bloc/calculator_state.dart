import 'package:equatable/equatable.dart';
import '../../domain/entities/loan_calculation.dart';

enum CalculatorStatus { initial, loading, success, error }

class CalculatorState extends Equatable {
  final CalculatorStatus status;
  final LoanCalculation? calculation;
  final double amount;
  final double interestRate;
  final int duration;
  final String frequency;
  final String interestType;
  final String? errorMessage;

  const CalculatorState({
    this.status = CalculatorStatus.initial,
    this.calculation,
    this.amount = 50000.0,
    this.interestRate = 24.0,
    this.duration = 30,
    this.frequency = 'daily',
    this.interestType = 'flat_percentage',
    this.errorMessage,
  });

  CalculatorState copyWith({
    CalculatorStatus? status,
    LoanCalculation? calculation,
    double? amount,
    double? interestRate,
    int? duration,
    String? frequency,
    String? interestType,
    String? errorMessage,
  }) {
    return CalculatorState(
      status: status ?? this.status,
      calculation: calculation ?? this.calculation,
      amount: amount ?? this.amount,
      interestRate: interestRate ?? this.interestRate,
      duration: duration ?? this.duration,
      frequency: frequency ?? this.frequency,
      interestType: interestType ?? this.interestType,
      errorMessage: errorMessage ?? this.errorMessage,
    );
  }

  @override
  List<Object?> get props => [
        status,
        calculation,
        amount,
        interestRate,
        duration,
        frequency,
        interestType,
        errorMessage,
      ];
}
