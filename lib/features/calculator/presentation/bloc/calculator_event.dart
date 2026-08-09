import 'package:equatable/equatable.dart';

abstract class CalculatorEvent extends Equatable {
  const CalculatorEvent();

  @override
  List<Object?> get props => [];
}

class UpdateCalculatorValues extends CalculatorEvent {
  final double? amount;
  final double? interestRate;
  final int? duration;
  final String? frequency;
  final String? interestType;

  const UpdateCalculatorValues({
    this.amount,
    this.interestRate,
    this.duration,
    this.frequency,
    this.interestType,
  });

  @override
  List<Object?> get props => [amount, interestRate, duration, frequency, interestType];
}

class CalculateLoan extends CalculatorEvent {}
