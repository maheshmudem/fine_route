import 'package:dartz/dartz.dart';
import '../../../../core/error/failures.dart';
import '../entities/route_line_entity.dart';

abstract class RouteLinesRepository {
  Future<Either<Failure, Map<String, List<String>>>> getAvailablePortions({String? excludeLineId});
  Future<Either<Failure, List<RouteLineEntity>>> getRouteLines();
  Future<Either<Failure, RouteLineEntity>> createRouteLine(String name, String area, List<DayScheduleEntity> schedules);
  Future<Either<Failure, RouteLineEntity>> updateRouteLine(String publicId, String name, String area, List<DayScheduleEntity> schedules);
  Future<Either<Failure, void>> deleteRouteLine(String publicId);
}
