import 'package:dartz/dartz.dart';
import '../../../../core/error/failures.dart';
import '../../data/models/login_request.dart';
import '../entities/auth_entity.dart';

abstract class AuthRepository {
  Future<Either<Failure, AuthEntity>> login(LoginRequest request);
  Future<void> logout();
  Future<Either<Failure, void>> changePassword(String oldPassword, String newPassword, String confirmPassword);
}
