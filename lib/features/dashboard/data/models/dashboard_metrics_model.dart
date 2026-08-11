import '../../domain/entities/dashboard_metrics.dart';

class DashboardMetricsModel extends DashboardMetrics {
  const DashboardMetricsModel({
    required super.totalCustomers,
    required super.activeLoans,
    required super.collectionsToday,
    required super.amountCollectedToday,
    required super.amountCollectedThisWeek,
    required super.disbursementsToday,
    required super.newBorrowersToday,
    required super.capitalToday,
    required super.expensesToday,
    required super.netCashToday,
    required super.isCashDeficit,
    required super.outstandingBalance,
    required super.pendingToday,
    required super.expensesThisMonth,
  });

  factory DashboardMetricsModel.fromJson(Map<String, dynamic> json) {
    return DashboardMetricsModel(
      totalCustomers: json['total_customers'] as int? ?? 0,
      activeLoans: json['active_loans'] as int? ?? 0,
      collectionsToday: json['collections_today'] as int? ?? 0,
      amountCollectedToday: (json['amount_collected_today'] as num?)?.toDouble() ?? 0.0,
      amountCollectedThisWeek: (json['amount_collected_this_week'] as num?)?.toDouble() ?? 0.0,
      disbursementsToday: (json['disbursements_today'] as num?)?.toDouble() ?? 0.0,
      newBorrowersToday: json['new_borrowers_today'] as int? ?? 0,
      capitalToday: (json['capital_today'] as num?)?.toDouble() ?? 0.0,
      expensesToday: (json['expenses_today'] as num?)?.toDouble() ?? 0.0,
      netCashToday: (json['net_cash_today'] as num?)?.toDouble() ?? 0.0,
      isCashDeficit: json['is_cash_deficit'] as bool? ?? false,
      outstandingBalance: (json['outstanding_balance'] as num?)?.toDouble() ?? 0.0,
      pendingToday: json['pending_today'] as int? ?? 0,
      expensesThisMonth: (json['expenses_this_month'] as num?)?.toDouble() ?? 0.0,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'total_customers': totalCustomers,
      'active_loans': activeLoans,
      'collections_today': collectionsToday,
      'amount_collected_today': amountCollectedToday,
      'amount_collected_this_week': amountCollectedThisWeek,
      'disbursements_today': disbursementsToday,
      'new_borrowers_today': newBorrowersToday,
      'capital_today': capitalToday,
      'expenses_today': expensesToday,
      'net_cash_today': netCashToday,
      'is_cash_deficit': isCashDeficit,
      'outstanding_balance': outstandingBalance,
      'pending_today': pendingToday,
      'expenses_this_month': expensesThisMonth,
    };
  }
}
