import '../../domain/entities/loan_calculation.dart';

class LoanInstallmentModel extends LoanInstallment {
  const LoanInstallmentModel({
    required super.installmentNumber,
    required super.dueDate,
    required super.installmentAmount,
    required super.remainingBalance,
  });

  factory LoanInstallmentModel.fromJson(Map<String, dynamic> json) {
    return LoanInstallmentModel(
      installmentNumber: json['installment_number'] as int,
      dueDate: json['due_date'] as String,
      installmentAmount: (json['installment_amount'] as num).toDouble(),
      remainingBalance: (json['remaining_balance'] as num).toDouble(),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'installment_number': installmentNumber,
      'due_date': dueDate,
      'installment_amount': installmentAmount,
      'remaining_balance': remainingBalance,
    };
  }
}

class LoanCalculationModel extends LoanCalculation {
  const LoanCalculationModel({
    required super.principalAmount,
    required super.interestRate,
    required super.interestType,
    required super.totalInterest,
    required super.totalPayable,
    required super.installmentAmount,
    required super.frequency,
    required super.duration,
    required super.schedule,
  });

  factory LoanCalculationModel.fromJson(Map<String, dynamic> json) {
    final scheduleList = json['schedule'] as List? ?? [];
    final List<LoanInstallmentModel> schedule = scheduleList
        .map((i) => LoanInstallmentModel.fromJson(i as Map<String, dynamic>))
        .toList();

    return LoanCalculationModel(
      principalAmount: (json['principal_amount'] as num).toDouble(),
      interestRate: (json['interest_rate'] as num).toDouble(),
      interestType: json['interest_type'] as String,
      totalInterest: (json['total_interest'] as num).toDouble(),
      totalPayable: (json['total_payable'] as num).toDouble(),
      installmentAmount: (json['installment_amount'] as num).toDouble(),
      frequency: json['frequency'] as String,
      duration: json['duration'] as int,
      schedule: schedule,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'principal_amount': principalAmount,
      'interest_rate': interestRate,
      'interest_type': interestType,
      'total_interest': totalInterest,
      'total_payable': totalPayable,
      'installment_amount': installmentAmount,
      'frequency': frequency,
      'duration': duration,
      'schedule': schedule.map((i) => (i as LoanInstallmentModel).toJson()).toList(),
    };
  }
}
