import '../../domain/entities/weekly_summary.dart';

class WeeklySummaryModel extends WeeklySummary {
  const WeeklySummaryModel({
    required super.date,
    required super.dayName,
    required super.amountCollected,
    required super.count,
  });

  factory WeeklySummaryModel.fromJson(Map<String, dynamic> json) {
    return WeeklySummaryModel(
      date: json['date'] as String? ?? '',
      dayName: json['day_name'] as String? ?? '',
      amountCollected: (json['amount_collected'] as num?)?.toDouble() ?? 0.0,
      count: json['count'] as int? ?? 0,
    );
  }
}
