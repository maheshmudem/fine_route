import 'package:dartz/dartz.dart';
import '../../../../core/error/exceptions.dart';
import '../../../../core/error/failures.dart';
import '../../domain/entities/route_line_entity.dart';
import '../../domain/repositories/route_lines_repository.dart';
import '../datasources/route_lines_remote_data_source.dart';

class RouteLinesRepositoryImpl implements RouteLinesRepository {
  final RouteLinesRemoteDataSource remoteDataSource;

  RouteLinesRepositoryImpl({required this.remoteDataSource});

  @override
  Future<Either<Failure, Map<String, List<String>>>> getAvailablePortions({String? excludeLineId}) async {
    try {
      final portions = await remoteDataSource.getAvailablePortions(excludeLineId: excludeLineId);
      return Right(portions);
    } on ServerException catch (e) {
      return Left(ServerFailure(message: e.message, code: e.code));
    } catch (e) {
      return Left(ServerFailure(message: 'Unexpected error occurred: $e'));
    }
  }

  @override
  Future<Either<Failure, List<RouteLineEntity>>> getRouteLines() async {
    try {
      final lines = await remoteDataSource.getRouteLines();
      return Right(lines);
    } on ServerException catch (e) {
      return Left(ServerFailure(message: e.message, code: e.code));
    } catch (e) {
      return Left(ServerFailure(message: 'Unexpected error occurred: $e'));
    }
  }

  @override
  Future<Either<Failure, RouteLineEntity>> createRouteLine(String name, String area, List<DayScheduleEntity> schedules) async {
    try {
      final payloadSchedules = schedules.map((e) => {
        'day_of_week': e.dayOfWeek,
        'portion': e.portion,
      }).toList();
      final line = await remoteDataSource.createRouteLine(name, area, payloadSchedules);
      return Right(line);
    } on ServerException catch (e) {
      return Left(ServerFailure(message: e.message, code: e.code));
    } catch (e) {
      return Left(ServerFailure(message: 'Unexpected error occurred: $e'));
    }
  }

  @override
  Future<Either<Failure, RouteLineEntity>> updateRouteLine(String publicId, String name, String area, List<DayScheduleEntity> schedules) async {
    try {
      final payloadSchedules = schedules.map((e) => {
        'day_of_week': e.dayOfWeek,
        'portion': e.portion,
      }).toList();
      final line = await remoteDataSource.updateRouteLine(publicId, name, area, payloadSchedules);
      return Right(line);
    } on ServerException catch (e) {
      return Left(ServerFailure(message: e.message, code: e.code));
    } catch (e) {
      return Left(ServerFailure(message: 'Unexpected error occurred: $e'));
    }
  }

  @override
  Future<Either<Failure, void>> deleteRouteLine(String publicId) async {
    try {
      await remoteDataSource.deleteRouteLine(publicId);
      return const Right(null);
    } on ServerException catch (e) {
      return Left(ServerFailure(message: e.message, code: e.code));
    } catch (e) {
      return Left(ServerFailure(message: 'Unexpected error occurred: $e'));
    }
  }
}
