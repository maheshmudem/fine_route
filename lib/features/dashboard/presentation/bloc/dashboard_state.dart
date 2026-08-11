import 'package:equatable/equatable.dart';
import '../../domain/entities/dashboard_data.dart';
import '../../domain/entities/weekly_summary.dart';

abstract class DashboardState extends Equatable {
  const DashboardState();
  
  @override
  List<Object?> get props => [];
}

class DashboardInitial extends DashboardState {}

class DashboardLoading extends DashboardState {}

class DashboardLoaded extends DashboardState {
  final DashboardData dashboardData;
  final List<WeeklySummary> weeklySummary;

  const DashboardLoaded({
    required this.dashboardData,
    required this.weeklySummary,
  });

  @override
  List<Object?> get props => [dashboardData, weeklySummary];
}

class DashboardError extends DashboardState {
  final String message;

  const DashboardError({required this.message});

  @override
  List<Object?> get props => [message];
}
