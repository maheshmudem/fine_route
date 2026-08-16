import 'package:equatable/equatable.dart';
import '../../../domain/entities/route_line_entity.dart';

abstract class RouteLinesState extends Equatable {
  const RouteLinesState();
  
  @override
  List<Object?> get props => [];
}

class RouteLinesInitial extends RouteLinesState {}

class RouteLinesLoading extends RouteLinesState {}

class RouteLinesLoaded extends RouteLinesState {
  final List<RouteLineEntity> lines;
  const RouteLinesLoaded(this.lines);

  @override
  List<Object?> get props => [lines];
}

class RouteLinesError extends RouteLinesState {
  final String message;
  const RouteLinesError(this.message);

  @override
  List<Object?> get props => [message];
}

class RouteLineActionLoading extends RouteLinesLoaded {
  const RouteLineActionLoading(super.lines);
}

class RouteLineActionSuccess extends RouteLinesLoaded {
  const RouteLineActionSuccess(super.lines);
}
