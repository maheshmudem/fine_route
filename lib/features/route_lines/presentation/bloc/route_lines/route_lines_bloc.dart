import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../domain/repositories/route_lines_repository.dart';
import 'route_lines_event.dart';
import 'route_lines_state.dart';

class RouteLinesBloc extends Bloc<RouteLinesEvent, RouteLinesState> {
  final RouteLinesRepository repository;

  RouteLinesBloc({required this.repository}) : super(RouteLinesInitial()) {
    on<LoadRouteLinesEvent>(_onLoadRouteLines);
    on<DeleteRouteLineEvent>(_onDeleteRouteLine);
  }

  Future<void> _onLoadRouteLines(LoadRouteLinesEvent event, Emitter<RouteLinesState> emit) async {
    emit(RouteLinesLoading());

    final result = await repository.getRouteLines();

    result.fold(
      (failure) => emit(RouteLinesError(failure.message)),
      (lines) => emit(RouteLinesLoaded(lines)),
    );
  }

  Future<void> _onDeleteRouteLine(DeleteRouteLineEvent event, Emitter<RouteLinesState> emit) async {
    if (state is RouteLinesLoaded) {
      final currentLines = (state as RouteLinesLoaded).lines;
      emit(RouteLineActionLoading(currentLines));

      final result = await repository.deleteRouteLine(event.publicId);

      result.fold(
        (failure) {
          emit(RouteLinesError(failure.message));
          emit(RouteLinesLoaded(currentLines));
        },
        (_) {
          final newLines = currentLines.where((l) => l.publicId != event.publicId).toList();
          emit(RouteLineActionSuccess(newLines));
          emit(RouteLinesLoaded(newLines));
        },
      );
    }
  }
}
