import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../domain/repositories/route_lines_repository.dart';
import 'create_route_line_event.dart';
import 'create_route_line_state.dart';

class CreateRouteLineBloc extends Bloc<CreateRouteLineEvent, CreateRouteLineState> {
  final RouteLinesRepository repository;

  CreateRouteLineBloc({required this.repository}) : super(CreateRouteLineInitial()) {
    on<LoadAvailablePortionsEvent>(_onLoadAvailablePortions);
    on<SubmitRouteLineEvent>(_onSubmitRouteLine);
    on<UpdateRouteLineEvent>(_onUpdateRouteLine);
  }

  Future<void> _onLoadAvailablePortions(LoadAvailablePortionsEvent event, Emitter<CreateRouteLineState> emit) async {
    emit(CreateRouteLineLoadingPortions());

    final result = await repository.getAvailablePortions(excludeLineId: event.excludeLineId);

    result.fold(
      (failure) => emit(CreateRouteLineError(failure.message)),
      (portions) => emit(CreateRouteLinePortionsLoaded(portions)),
    );
  }

  Future<void> _onSubmitRouteLine(SubmitRouteLineEvent event, Emitter<CreateRouteLineState> emit) async {
    final currentState = state;
    emit(CreateRouteLineSubmitting());

    final result = await repository.createRouteLine(event.name, event.area, event.schedules);

    result.fold(
      (failure) {
        emit(CreateRouteLineError(failure.message));
        if (currentState is CreateRouteLinePortionsLoaded) {
          emit(currentState); // Revert to portions loaded state so user can try again
        }
      },
      (routeLine) => emit(CreateRouteLineSuccess(routeLine)),
    );
  }

  Future<void> _onUpdateRouteLine(UpdateRouteLineEvent event, Emitter<CreateRouteLineState> emit) async {
    final currentState = state;
    emit(CreateRouteLineSubmitting());

    final result = await repository.updateRouteLine(event.publicId, event.name, event.area, event.schedules);

    result.fold(
      (failure) {
        emit(CreateRouteLineError(failure.message));
        if (currentState is CreateRouteLinePortionsLoaded) {
          emit(currentState); // Revert to portions loaded state so user can try again
        }
      },
      (routeLine) => emit(CreateRouteLineSuccess(routeLine)),
    );
  }
}
