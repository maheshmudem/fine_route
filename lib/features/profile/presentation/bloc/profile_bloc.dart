import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../core/usecase/usecase.dart';
import '../../domain/usecases/get_profile_usecase.dart';
import '../../domain/usecases/update_profile_usecase.dart';
import 'profile_event.dart';
import 'profile_state.dart';

class ProfileBloc extends Bloc<ProfileEvent, ProfileState> {
  final GetProfileUseCase getProfileUseCase;
  final UpdateProfileUseCase updateProfileUseCase;

  ProfileBloc({
    required this.getProfileUseCase,
    required this.updateProfileUseCase,
  }) : super(ProfileInitial()) {
    on<GetProfileEvent>(_onGetProfile);
    on<UpdateProfileEvent>(_onUpdateProfile);
  }

  Future<void> _onGetProfile(GetProfileEvent event, Emitter<ProfileState> emit) async {
    emit(ProfileLoading());
    final result = await getProfileUseCase(const NoParams());
    result.fold(
      (failure) => emit(ProfileError(message: failure.message)),
      (profile) => emit(ProfileLoaded(profile: profile)),
    );
  }

  Future<void> _onUpdateProfile(UpdateProfileEvent event, Emitter<ProfileState> emit) async {
    emit(ProfileUpdating());
    final result = await updateProfileUseCase(UpdateProfileParams(
      fullName: event.fullName,
      mobileNumber: event.mobileNumber,
      email: event.email,
      city: event.city,
      state: event.state,
    ));
    result.fold(
      (failure) => emit(ProfileUpdateError(message: failure.message)),
      (profile) {
        emit(ProfileUpdateSuccess(profile: profile));
        // Emit loaded state to update UI
        emit(ProfileLoaded(profile: profile));
      },
    );
  }
}
