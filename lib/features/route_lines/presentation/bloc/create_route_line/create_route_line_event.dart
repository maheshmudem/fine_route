import 'package:equatable/equatable.dart';
import '../../../domain/entities/route_line_entity.dart';

abstract class CreateRouteLineEvent extends Equatable {
  const CreateRouteLineEvent();

  @override
  List<Object?> get props => [];
}

class LoadAvailablePortionsEvent extends CreateRouteLineEvent {
  final String? excludeLineId;
  const LoadAvailablePortionsEvent({this.excludeLineId});

  @override
  List<Object?> get props => [excludeLineId];
}

class SubmitRouteLineEvent extends CreateRouteLineEvent {
  final String name;
  final String area;
  final List<DayScheduleEntity> schedules;

  const SubmitRouteLineEvent({
    required this.name,
    required this.area,
    required this.schedules,
  });

  @override
  List<Object?> get props => [name, area, schedules];
}

class UpdateRouteLineEvent extends CreateRouteLineEvent {
  final String publicId;
  final String name;
  final String area;
  final List<DayScheduleEntity> schedules;

  const UpdateRouteLineEvent({
    required this.publicId,
    required this.name,
    required this.area,
    required this.schedules,
  });

  @override
  List<Object?> get props => [publicId, name, area, schedules];
}
