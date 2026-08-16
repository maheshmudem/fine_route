import '../../domain/entities/route_line_entity.dart';

class RouteLineModel extends RouteLineEntity {
  const RouteLineModel({
    required super.publicId,
    required super.name,
    required super.area,
    required super.isActive,
    required super.customersCount,
    required super.daySchedules,
    required super.createdAt,
  });

  factory RouteLineModel.fromJson(Map<String, dynamic> json) {
    return RouteLineModel(
      publicId: json['public_id'],
      name: json['name'],
      area: json['area'] ?? '',
      isActive: json['is_active'] ?? true,
      customersCount: json['customers_count'] ?? 0,
      daySchedules: (json['day_schedules'] as List?)
              ?.map((e) => DayScheduleModel.fromJson(e))
              .toList() ??
          [],
      createdAt: DateTime.parse(json['created_at']),
    );
  }
}

class DayScheduleModel extends DayScheduleEntity {
  const DayScheduleModel({
    required super.dayOfWeek,
    required super.portion,
  });

  factory DayScheduleModel.fromJson(Map<String, dynamic> json) {
    return DayScheduleModel(
      dayOfWeek: json['day_of_week'],
      portion: json['portion'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'day_of_week': dayOfWeek,
      'portion': portion,
    };
  }
}
