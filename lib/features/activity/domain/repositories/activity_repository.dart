import 'package:dartz/dartz.dart';
import '../../../../core/error/failures.dart';
import '../entities/activity_log.dart';

abstract class ActivityRepository {
  Future<Either<Failure, List<ActivityLog>>> getActivities({int page = 1, int pageSize = 100});
}
