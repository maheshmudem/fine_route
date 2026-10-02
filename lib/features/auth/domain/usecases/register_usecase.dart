import 'package:dartz/dartz.dart';
import '../../../../core/error/failures.dart';
import '../../../../core/usecase/usecase.dart';
import '../../data/models/register_request.dart';
import '../repositories/auth_repository.dart';

class RegisterUseCase implements UseCase<void, RegisterRequest> {
  final AuthRepository repository;

  RegisterUseCase(this.repository);

  @override
  Future<Either<Failure, void>> call(RegisterRequest params) {
    return repository.register(params);
  }
}
