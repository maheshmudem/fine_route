import 'package:equatable/equatable.dart';

abstract class SessionEvent extends Equatable {
  const SessionEvent();

  @override
  List<Object?> get props => [];
}

class LoadSessionsEvent extends SessionEvent {}

class RevokeSessionEvent extends SessionEvent {
  final int id;

  const RevokeSessionEvent(this.id);

  @override
  List<Object?> get props => [id];
}
