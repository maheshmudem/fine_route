import 'package:flutter_bloc/flutter_bloc.dart';
import '../../domain/repositories/session_repository.dart';
import 'session_event.dart';
import 'session_state.dart';

class SessionBloc extends Bloc<SessionEvent, SessionState> {
  final SessionRepository repository;

  SessionBloc({required this.repository}) : super(SessionInitial()) {
    on<LoadSessionsEvent>(_onLoadSessions);
    on<RevokeSessionEvent>(_onRevokeSession);
  }

  Future<void> _onLoadSessions(LoadSessionsEvent event, Emitter<SessionState> emit) async {
    emit(SessionLoading());

    final result = await repository.getSessions(page: 1, pageSize: 100);

    result.fold(
      (failure) => emit(SessionError(message: failure.message)),
      (sessions) => emit(SessionLoaded(sessions: sessions)),
    );
  }

  Future<void> _onRevokeSession(RevokeSessionEvent event, Emitter<SessionState> emit) async {
    if (state is SessionLoaded) {
      final currentSessions = (state as SessionLoaded).sessions;
      emit(SessionActionLoading(sessions: currentSessions));

      final result = await repository.revokeSession(event.id);

      result.fold(
        (failure) {
          emit(SessionError(message: failure.message));
          emit(SessionLoaded(sessions: currentSessions)); // Restore list on error
        },
        (_) {
          final newSessions = currentSessions.where((s) => s.id != event.id).toList();
          emit(SessionActionSuccess(sessions: newSessions));
          emit(SessionLoaded(sessions: newSessions));
        },
      );
    }
  }
}
