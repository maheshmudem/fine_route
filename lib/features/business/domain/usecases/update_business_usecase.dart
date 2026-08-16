import 'package:dartz/dartz.dart';
import '../../../../core/error/failures.dart';
import '../../../../core/usecase/usecase.dart';
import '../entities/business.dart';
import '../repositories/business_repository.dart';

class UpdateBusinessParams {
  final Map<String, dynamic> changedFields;

  UpdateBusinessParams({
    required this.changedFields,
  });

  Map<String, dynamic> toJson() => changedFields;
}

class UpdateBusinessUseCase implements UseCase<Business, UpdateBusinessParams> {
  final BusinessRepository repository;

  UpdateBusinessUseCase(this.repository);

  @override
  Future<Either<Failure, Business>> call(UpdateBusinessParams params) {
    return repository.updateBusiness(params.toJson());
  }
}
