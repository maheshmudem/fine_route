import 'package:dartz/dartz.dart';
import '../../../../core/error/failures.dart';
import '../entities/device_session.dart';

abstract class DeviceRepository {
  Future<Either<Failure, List<DeviceSession>>> getSessions({int page = 1, int pageSize = 100});
  Future<Either<Failure, void>> revokeSession(int id);
}
