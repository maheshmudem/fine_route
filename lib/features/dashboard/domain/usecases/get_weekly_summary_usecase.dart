import 'package:dartz/dartz.dart';
import '../../../../core/error/failures.dart';
import '../../../../core/usecase/usecase.dart';
import '../entities/weekly_summary.dart';
import '../repositories/dashboard_repository.dart';

class GetWeeklySummaryUseCase implements UseCase<List<WeeklySummary>, NoParams> {
  final DashboardRepository repository;

  GetWeeklySummaryUseCase(this.repository);

  @override
  Future<Either<Failure, List<WeeklySummary>>> call(NoParams params) async {
    return await repository.getWeeklySummary();
  }
}
