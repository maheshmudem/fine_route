import 'package:equatable/equatable.dart';

class RouteLineEntity extends Equatable {
  final String publicId;
  final String name;
  final String area;
  final bool isActive;
  final int customersCount;
  final List<DayScheduleEntity> daySchedules;
  final DateTime createdAt;

  const RouteLineEntity({
    required this.publicId,
    required this.name,
    required this.area,
    required this.isActive,
    required this.customersCount,
    required this.daySchedules,
    required this.createdAt,
  });

  @override
  List<Object?> get props => [publicId, name, area, isActive, customersCount, daySchedules, createdAt];
}

class DayScheduleEntity extends Equatable {
  final String dayOfWeek;
  final String portion;

  const DayScheduleEntity({
    required this.dayOfWeek,
    required this.portion,
  });

  @override
  List<Object?> get props => [dayOfWeek, portion];
}
