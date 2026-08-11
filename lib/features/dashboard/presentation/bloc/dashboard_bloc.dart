import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../core/usecase/usecase.dart';
import '../../domain/usecases/get_dashboard_data_usecase.dart';
import '../../domain/usecases/get_weekly_summary_usecase.dart';
import 'dashboard_event.dart';
import 'dashboard_state.dart';

class DashboardBloc extends Bloc<DashboardEvent, DashboardState> {
  final GetDashboardDataUseCase getDashboardData;
  final GetWeeklySummaryUseCase getWeeklySummary;

  DashboardBloc({
    required this.getDashboardData,
    required this.getWeeklySummary,
  }) : super(DashboardInitial()) {
    on<LoadDashboardData>(_onLoadDashboardData);
  }

  Future<void> _onLoadDashboardData(
    LoadDashboardData event,
    Emitter<DashboardState> emit,
  ) async {
    emit(DashboardLoading());

    // Run both requests concurrently
    final dashboardResultFuture = getDashboardData(NoParams());
    final weeklySummaryResultFuture = getWeeklySummary(NoParams());

    final results = await Future.wait([dashboardResultFuture, weeklySummaryResultFuture]);

    final dashboardResult = results[0];
    final weeklySummaryResult = results[1];

    dashboardResult.fold(
      (failure) => emit(DashboardError(message: failure.message)),
      (dashboardData) {
        weeklySummaryResult.fold(
          (failure) => emit(DashboardError(message: failure.message)),
          (weeklySummary) => emit(DashboardLoaded(
            dashboardData: dashboardData as dynamic,
            weeklySummary: weeklySummary as dynamic,
          )),
        );
      },
    );
  }
}
