import 'package:equatable/equatable.dart';
import 'dashboard_metrics.dart';
import 'recent_collection.dart';

class DashboardData extends Equatable {
  final DashboardMetrics metrics;
  final List<RecentCollection> recentCollections;

  const DashboardData({
    required this.metrics,
    required this.recentCollections,
  });

  @override
  List<Object?> get props => [metrics, recentCollections];
}
