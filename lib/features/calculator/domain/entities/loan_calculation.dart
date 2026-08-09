import 'package:equatable/equatable.dart';

class LoanInstallment extends Equatable {
  final int installmentNumber;
  final String dueDate;
  final double installmentAmount;
  final double remainingBalance;

  const LoanInstallment({
    required this.installmentNumber,
    required this.dueDate,
    required this.installmentAmount,
    required this.remainingBalance,
  });

  @override
  List<Object?> get props => [
        installmentNumber,
        dueDate,
        installmentAmount,
        remainingBalance,
      ];
}

class LoanCalculation extends Equatable {
  final double principalAmount;
  final double interestRate;
  final String interestType;
  final double totalInterest;
  final double totalPayable;
  final double installmentAmount;
  final String frequency;
  final int duration;
  final List<LoanInstallment> schedule;

  const LoanCalculation({
    required this.principalAmount,
    required this.interestRate,
    required this.interestType,
    required this.totalInterest,
    required this.totalPayable,
    required this.installmentAmount,
    required this.frequency,
    required this.duration,
    required this.schedule,
  });

  @override
  List<Object?> get props => [
        principalAmount,
        interestRate,
        interestType,
        totalInterest,
        totalPayable,
        installmentAmount,
        frequency,
        duration,
        schedule,
      ];
}
