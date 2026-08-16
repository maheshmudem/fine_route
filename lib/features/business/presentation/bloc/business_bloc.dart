import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../core/usecase/usecase.dart';
import '../../domain/usecases/get_business_usecase.dart';
import '../../domain/usecases/update_business_usecase.dart';
import 'business_event.dart';
import 'business_state.dart';

class BusinessBloc extends Bloc<BusinessEvent, BusinessState> {
  final GetBusinessUseCase getBusinessUseCase;
  final UpdateBusinessUseCase updateBusinessUseCase;

  BusinessBloc({
    required this.getBusinessUseCase,
    required this.updateBusinessUseCase,
  }) : super(BusinessInitial()) {
    on<GetBusinessEvent>(_onGetBusiness);
    on<UpdateBusinessEvent>(_onUpdateBusiness);
  }

  Future<void> _onGetBusiness(GetBusinessEvent event, Emitter<BusinessState> emit) async {
    emit(BusinessLoading());
    final result = await getBusinessUseCase(const NoParams());
    result.fold(
      (failure) => emit(BusinessError(message: failure.message)),
      (business) => emit(BusinessLoaded(business: business)),
    );
  }

  Future<void> _onUpdateBusiness(UpdateBusinessEvent event, Emitter<BusinessState> emit) async {
    emit(BusinessUpdating());
    final result = await updateBusinessUseCase(UpdateBusinessParams(
      changedFields: event.changedFields,
    ));
    result.fold(
      (failure) => emit(BusinessUpdateError(message: failure.message)),
      (business) {
        emit(BusinessUpdateSuccess(business: business));
        // Emit loaded state to update UI
        emit(BusinessLoaded(business: business));
      },
    );
  }
}
