import 'package:flutter_bloc/flutter_bloc.dart';
import '../../data/models/register_request.dart';
import '../../data/models/otp_request.dart';
import '../../domain/usecases/register_usecase.dart';
import '../../domain/usecases/resend_otp_usecase.dart';
import '../../domain/usecases/verify_otp_usecase.dart';
import 'register_event.dart';
import 'register_state.dart';

class RegisterBloc extends Bloc<RegisterEvent, RegisterState> {
  final RegisterUseCase registerUseCase;
  final ResendOtpUseCase resendOtpUseCase;
  final VerifyOtpUseCase verifyOtpUseCase;

  RegisterBloc({
    required this.registerUseCase,
    required this.resendOtpUseCase,
    required this.verifyOtpUseCase,
  }) : super(RegisterInitial()) {
    on<SubmitRegistrationEvent>(_onSubmitRegistration);
    on<ResendOtpEvent>(_onResendOtp);
    on<SubmitOtpVerificationEvent>(_onSubmitOtpVerification);
  }

  Future<void> _onSubmitRegistration(SubmitRegistrationEvent event, Emitter<RegisterState> emit) async {
    emit(RegisterLoading());
    final result = await registerUseCase(RegisterRequest(
      fullName: event.fullName,
      mobileNumber: event.mobileNumber,
      email: event.email,
      password: event.password,
      confirmPassword: event.confirmPassword,
    ));
    result.fold(
      (failure) => emit(RegisterError(message: failure.message)),
      (_) => emit(RegisterSuccess()),
    );
  }

  Future<void> _onResendOtp(ResendOtpEvent event, Emitter<RegisterState> emit) async {
    emit(RegisterLoading());
    final result = await resendOtpUseCase(OtpRequest(
      mobileNumber: event.mobileNumber,
      purpose: event.purpose,
    ));
    result.fold(
      (failure) => emit(RegisterError(message: failure.message)),
      (_) => emit(const OtpResendSuccess(message: 'OTP resent successfully')),
    );
  }

  Future<void> _onSubmitOtpVerification(SubmitOtpVerificationEvent event, Emitter<RegisterState> emit) async {
    emit(RegisterLoading());
    final result = await verifyOtpUseCase(OtpRequest(
      mobileNumber: event.mobileNumber,
      purpose: event.purpose,
      otp: event.otp,
    ));
    result.fold(
      (failure) => emit(RegisterError(message: failure.message)),
      (_) => emit(const OtpVerifySuccess(message: 'OTP verified successfully. Please login.')),
    );
  }
}
