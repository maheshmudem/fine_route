import 'package:equatable/equatable.dart';

abstract class RouteLinesEvent extends Equatable {
  const RouteLinesEvent();

  @override
  List<Object?> get props => [];
}

class LoadRouteLinesEvent extends RouteLinesEvent {}

class DeleteRouteLineEvent extends RouteLinesEvent {
  final String publicId;
  const DeleteRouteLineEvent(this.publicId);

  @override
  List<Object?> get props => [publicId];
}
