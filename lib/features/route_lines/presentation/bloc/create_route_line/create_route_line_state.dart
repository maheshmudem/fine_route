import 'package:equatable/equatable.dart';
import '../../../domain/entities/route_line_entity.dart';

abstract class CreateRouteLineState extends Equatable {
  const CreateRouteLineState();
  
  @override
  List<Object?> get props => [];
}

class CreateRouteLineInitial extends CreateRouteLineState {}

class CreateRouteLineLoadingPortions extends CreateRouteLineState {}

class CreateRouteLinePortionsLoaded extends CreateRouteLineState {
  final Map<String, List<String>> availablePortions;
  
  const CreateRouteLinePortionsLoaded(this.availablePortions);

  @override
  List<Object?> get props => [availablePortions];
}

class CreateRouteLineSubmitting extends CreateRouteLineState {}

class CreateRouteLineSuccess extends CreateRouteLineState {
  final RouteLineEntity routeLine;
  const CreateRouteLineSuccess(this.routeLine);

  @override
  List<Object?> get props => [routeLine];
}

class CreateRouteLineError extends CreateRouteLineState {
  final String message;
  const CreateRouteLineError(this.message);

  @override
  List<Object?> get props => [message];
}
