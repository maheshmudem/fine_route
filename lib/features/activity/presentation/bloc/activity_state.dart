import 'package:equatable/equatable.dart';
import '../../domain/entities/activity_log.dart';

abstract class ActivityState extends Equatable {
  const ActivityState();

  @override
  List<Object?> get props => [];
}

class ActivityInitial extends ActivityState {}

class ActivityLoading extends ActivityState {}

class ActivityLoaded extends ActivityState {
  final List<ActivityLog> activities;

  const ActivityLoaded({required this.activities});

  @override
  List<Object?> get props => [activities];
}

class ActivityError extends ActivityState {
  final String message;

  const ActivityError({required this.message});

  @override
  List<Object?> get props => [message];
}
