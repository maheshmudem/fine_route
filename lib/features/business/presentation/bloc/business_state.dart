import 'package:equatable/equatable.dart';
import '../../domain/entities/business.dart';

abstract class BusinessState extends Equatable {
  const BusinessState();

  @override
  List<Object?> get props => [];
}

class BusinessInitial extends BusinessState {}

class BusinessLoading extends BusinessState {}

class BusinessLoaded extends BusinessState {
  final Business business;

  const BusinessLoaded({required this.business});

  @override
  List<Object?> get props => [business];
}

class BusinessError extends BusinessState {
  final String message;

  const BusinessError({required this.message});

  @override
  List<Object?> get props => [message];
}

class BusinessUpdating extends BusinessState {}

class BusinessUpdateSuccess extends BusinessState {
  final Business business;

  const BusinessUpdateSuccess({required this.business});

  @override
  List<Object?> get props => [business];
}

class BusinessUpdateError extends BusinessState {
  final String message;

  const BusinessUpdateError({required this.message});

  @override
  List<Object?> get props => [message];
}
