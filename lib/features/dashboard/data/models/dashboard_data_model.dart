import '../../domain/entities/dashboard_data.dart';
import 'dashboard_metrics_model.dart';
import 'recent_collection_model.dart';

class DashboardDataModel extends DashboardData {
  const DashboardDataModel({
    required super.metrics,
    required super.recentCollections,
  });

  factory DashboardDataModel.fromJson(Map<String, dynamic> json) {
    return DashboardDataModel(
      metrics: DashboardMetricsModel.fromJson(json['metrics'] ?? {}),
      recentCollections: (json['recent_collections'] as List<dynamic>?)
              ?.map((e) => RecentCollectionModel.fromJson(e as Map<String, dynamic>))
              .toList() ??
          [],
    );
  }
}
