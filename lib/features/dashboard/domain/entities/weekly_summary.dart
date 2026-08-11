import 'package:equatable/equatable.dart';

class WeeklySummary extends Equatable {
  final String date;
  final String dayName;
  final double amountCollected;
  final int count;

  const WeeklySummary({
    required this.date,
    required this.dayName,
    required this.amountCollected,
    required this.count,
  });

  @override
  List<Object?> get props => [date, dayName, amountCollected, count];
}
