import 'package:dartz/dartz.dart';
import '../../../../core/error/failures.dart';
import '../entities/session_entity.dart';

abstract class SessionRepository {
  Future<Either<Failure, List<SessionEntity>>> getSessions({int page = 1, int pageSize = 100});
  Future<Either<Failure, void>> revokeSession(int id);
}
