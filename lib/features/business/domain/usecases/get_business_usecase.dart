import 'package:dartz/dartz.dart';
import '../../../../core/error/failures.dart';
import '../../../../core/usecase/usecase.dart';
import '../entities/business.dart';
import '../repositories/business_repository.dart';

class GetBusinessUseCase implements UseCase<Business, NoParams> {
  final BusinessRepository repository;

  GetBusinessUseCase(this.repository);

  @override
  Future<Either<Failure, Business>> call(NoParams params) {
    return repository.getBusiness();
  }
}
