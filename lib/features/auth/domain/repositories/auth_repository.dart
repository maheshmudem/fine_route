import 'package:dartz/dartz.dart';
import '../../../../core/error/failures.dart';
import '../../data/models/login_request.dart';
import '../../data/models/register_request.dart';
import '../../data/models/otp_request.dart';
import '../entities/auth_entity.dart';

abstract class AuthRepository {
  Future<Either<Failure, AuthEntity>> login(LoginRequest request);
  Future<void> logout();
  Future<Either<Failure, void>> changePassword(String oldPassword, String newPassword, String confirmPassword);
  Future<Either<Failure, void>> register(RegisterRequest request);
  Future<Either<Failure, void>> resendOtp(OtpRequest request);
  Future<Either<Failure, void>> verifyOtp(OtpRequest request);
}
