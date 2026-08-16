import 'package:flutter_bloc/flutter_bloc.dart';
import '../../domain/repositories/activity_repository.dart';
import 'activity_event.dart';
import 'activity_state.dart';

class ActivityBloc extends Bloc<ActivityEvent, ActivityState> {
  final ActivityRepository repository;

  ActivityBloc({required this.repository}) : super(ActivityInitial()) {
    on<FetchActivitiesEvent>(_onFetchActivities);
  }

  Future<void> _onFetchActivities(FetchActivitiesEvent event, Emitter<ActivityState> emit) async {
    emit(ActivityLoading());

    // Fetch up to 1000 items directly without pagination to show all data
    final result = await repository.getActivities(page: 1, pageSize: 1000);

    result.fold(
      (failure) => emit(ActivityError(message: failure.message)),
      (activities) => emit(ActivityLoaded(activities: activities)),
    );
  }
}
