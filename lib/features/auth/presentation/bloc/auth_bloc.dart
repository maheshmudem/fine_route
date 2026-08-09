import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import '../../../../core/constants/app_constants.dart';
import '../../../../core/usecase/usecase.dart';
import '../../domain/usecases/login_usecase.dart';
import '../../domain/usecases/logout_usecase.dart';
import 'auth_event.dart';
import 'auth_state.dart';

class AuthBloc extends Bloc<AuthEvent, AuthState> {
  final LoginUseCase _loginUseCase;
  final FlutterSecureStorage _secureStorage;
  final LogoutUseCase _logoutUseCase;

  AuthBloc(this._loginUseCase, this._secureStorage, this._logoutUseCase) : super(AuthInitial()) {
    on<LoginSubmitted>(_onLoginSubmitted);
    on<LogoutRequested>(_onLogoutRequested);
  }

  Future<void> _onLoginSubmitted(
    LoginSubmitted event,
    Emitter<AuthState> emit,
  ) async {
    emit(AuthLoading());

    final params = LoginParams(
      identifier: event.identifier,
      password: event.password,
    );

    final result = await _loginUseCase(params);

    await result.fold(
      (failure) async {
        emit(AuthFailure(message: failure.message));
      },
      (entity) async {
        // Save tokens
        await _secureStorage.write(
          key: AppConstants.jwtTokenKey,
          value: entity.accessToken,
        );
        emit(const AuthSuccess(message: 'Login successful'));
      },
    );
  }

  Future<void> _onLogoutRequested(
    LogoutRequested event,
    Emitter<AuthState> emit,
  ) async {
    await _logoutUseCase(const NoParams());
    emit(AuthUnauthenticated());
  }
}
