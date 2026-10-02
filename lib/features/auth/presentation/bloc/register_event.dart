import 'package:equatable/equatable.dart';

abstract class RegisterEvent extends Equatable {
  const RegisterEvent();

  @override
  List<Object?> get props => [];
}

class SubmitRegistrationEvent extends RegisterEvent {
  final String fullName;
  final String mobileNumber;
  final String email;
  final String password;
  final String confirmPassword;

  const SubmitRegistrationEvent({
    required this.fullName,
    required this.mobileNumber,
    required this.email,
    required this.password,
    required this.confirmPassword,
  });

  @override
  List<Object?> get props => [fullName, mobileNumber, email, password, confirmPassword];
}

class ResendOtpEvent extends RegisterEvent {
  final String mobileNumber;
  final String purpose;

  const ResendOtpEvent({
    required this.mobileNumber,
    required this.purpose,
  });

  @override
  List<Object?> get props => [mobileNumber, purpose];
}

class SubmitOtpVerificationEvent extends RegisterEvent {
  final String mobileNumber;
  final String purpose;
  final String otp;

  const SubmitOtpVerificationEvent({
    required this.mobileNumber,
    required this.purpose,
    required this.otp,
  });

  @override
  List<Object?> get props => [mobileNumber, purpose, otp];
}
