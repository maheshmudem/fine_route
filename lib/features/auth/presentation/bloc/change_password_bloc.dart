import 'package:flutter_bloc/flutter_bloc.dart';
import '../../domain/usecases/change_password_usecase.dart';
import 'change_password_event.dart';
import 'change_password_state.dart';

class ChangePasswordBloc extends Bloc<ChangePasswordEvent, ChangePasswordState> {
  final ChangePasswordUseCase changePasswordUseCase;

  ChangePasswordBloc({required this.changePasswordUseCase}) : super(ChangePasswordInitial()) {
    on<SubmitChangePasswordEvent>(_onSubmitChangePassword);
  }

  Future<void> _onSubmitChangePassword(SubmitChangePasswordEvent event, Emitter<ChangePasswordState> emit) async {
    emit(ChangePasswordLoading());
    final result = await changePasswordUseCase(ChangePasswordParams(
      oldPassword: event.oldPassword,
      newPassword: event.newPassword,
      confirmPassword: event.confirmPassword,
    ));
    result.fold(
      (failure) => emit(ChangePasswordError(message: failure.message)),
      (_) => emit(ChangePasswordSuccess()),
    );
  }
}
