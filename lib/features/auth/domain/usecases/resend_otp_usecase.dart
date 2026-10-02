import 'package:dartz/dartz.dart';
import '../../../../core/error/failures.dart';
import '../../../../core/usecase/usecase.dart';
import '../../data/models/otp_request.dart';
import '../repositories/auth_repository.dart';

class ResendOtpUseCase implements UseCase<void, OtpRequest> {
  final AuthRepository repository;

  ResendOtpUseCase(this.repository);

  @override
  Future<Either<Failure, void>> call(OtpRequest params) {
    return repository.resendOtp(params);
  }
}
