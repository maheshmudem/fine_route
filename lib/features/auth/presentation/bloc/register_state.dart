import 'package:equatable/equatable.dart';

abstract class RegisterState extends Equatable {
  const RegisterState();

  @override
  List<Object?> get props => [];
}

class RegisterInitial extends RegisterState {}

class RegisterLoading extends RegisterState {}

class RegisterSuccess extends RegisterState {}

class OtpResendSuccess extends RegisterState {
  final String message;

  const OtpResendSuccess({required this.message});

  @override
  List<Object?> get props => [message];
}

class OtpVerifySuccess extends RegisterState {
  final String message;

  const OtpVerifySuccess({required this.message});

  @override
  List<Object?> get props => [message];
}

class RegisterError extends RegisterState {
  final String message;

  const RegisterError({required this.message});

  @override
  List<Object?> get props => [message];
}
