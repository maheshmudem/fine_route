import 'package:dartz/dartz.dart';
import '../../../../core/error/failures.dart';
import '../../../../core/usecase/usecase.dart';
import '../../data/models/otp_request.dart';
import '../repositories/auth_repository.dart';

class VerifyOtpUseCase implements UseCase<void, OtpRequest> {
  final AuthRepository repository;

  VerifyOtpUseCase(this.repository);

  @override
  Future<Either<Failure, void>> call(OtpRequest params) {
    return repository.verifyOtp(params);
  }
}
