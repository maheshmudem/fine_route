import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import '../../../../core/constants/app_constants.dart';
import '../../data/models/login_request.dart';
import '../../data/repositories/auth_repository.dart';
import 'auth_event.dart';
import 'auth_state.dart';

class AuthBloc extends Bloc<AuthEvent, AuthState> {
  final AuthRepository _authRepository;
  final FlutterSecureStorage _secureStorage;

  AuthBloc(this._authRepository, this._secureStorage) : super(AuthInitial()) {
    on<LoginSubmitted>(_onLoginSubmitted);
  }

  Future<void> _onLoginSubmitted(
    LoginSubmitted event,
    Emitter<AuthState> emit,
  ) async {
    emit(AuthLoading());

    final request = LoginRequest(
      identifier: event.identifier,
      password: event.password,
    );

    final result = await _authRepository.login(request);

    await result.fold(
      (failure) async {
        emit(AuthFailure(message: failure.message));
      },
      (response) async {
        // Save tokens
        if (response.data != null) {
          await _secureStorage.write(
            key: AppConstants.jwtTokenKey,
            value: response.data!.accessToken,
          );
          // Optional: Save refresh token as well
        }
        emit(AuthSuccess(message: response.message));
      },
    );
  }
}
