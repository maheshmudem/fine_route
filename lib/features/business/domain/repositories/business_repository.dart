import 'package:dartz/dartz.dart';
import '../../../../core/error/failures.dart';
import '../entities/business.dart';

abstract class BusinessRepository {
  Future<Either<Failure, Business>> getBusiness();
  Future<Either<Failure, Business>> updateBusiness(Map<String, dynamic> data);
}
