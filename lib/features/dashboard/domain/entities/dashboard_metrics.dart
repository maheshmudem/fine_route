import 'package:equatable/equatable.dart';

class DashboardMetrics extends Equatable {
  final int totalCustomers;
  final int activeLoans;
  final int collectionsToday;
  final double amountCollectedToday;
  final double amountCollectedThisWeek;
  final double disbursementsToday;
  final int newBorrowersToday;
  final double capitalToday;
  final double expensesToday;
  final double netCashToday;
  final bool isCashDeficit;
  final double outstandingBalance;
  final int pendingToday;
  final double expensesThisMonth;

  const DashboardMetrics({
    required this.totalCustomers,
    required this.activeLoans,
    required this.collectionsToday,
    required this.amountCollectedToday,
    required this.amountCollectedThisWeek,
    required this.disbursementsToday,
    required this.newBorrowersToday,
    required this.capitalToday,
    required this.expensesToday,
    required this.netCashToday,
    required this.isCashDeficit,
    required this.outstandingBalance,
    required this.pendingToday,
    required this.expensesThisMonth,
  });

  @override
  List<Object?> get props => [
        totalCustomers,
        activeLoans,
        collectionsToday,
        amountCollectedToday,
        amountCollectedThisWeek,
        disbursementsToday,
        newBorrowersToday,
        capitalToday,
        expensesToday,
        netCashToday,
        isCashDeficit,
        outstandingBalance,
        pendingToday,
        expensesThisMonth,
      ];
}
