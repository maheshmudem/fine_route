import 'package:dartz/dartz.dart';
import '../../../../core/error/exceptions.dart';
import '../../../../core/error/failures.dart';
import '../../domain/entities/session_entity.dart';
import '../../domain/repositories/session_repository.dart';
import '../datasources/session_remote_data_source.dart';

class SessionRepositoryImpl implements SessionRepository {
  final SessionRemoteDataSource remoteDataSource;

  SessionRepositoryImpl({required this.remoteDataSource});

  @override
  Future<Either<Failure, List<SessionEntity>>> getSessions({int page = 1, int pageSize = 100}) async {
    try {
      final sessions = await remoteDataSource.getSessions(page: page, pageSize: pageSize);
      return Right(sessions);
    } on ServerException catch (e) {
      return Left(ServerFailure(message: e.message, code: e.code));
    } catch (e) {
      return Left(ServerFailure(message: 'Unexpected error occurred: $e'));
    }
  }

  @override
  Future<Either<Failure, void>> revokeSession(int id) async {
    try {
      await remoteDataSource.revokeSession(id);
      return const Right(null);
    } on ServerException catch (e) {
      return Left(ServerFailure(message: e.message, code: e.code));
    } catch (e) {
      return Left(ServerFailure(message: 'Unexpected error occurred: $e'));
    }
  }
}
