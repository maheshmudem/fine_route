import 'package:flutter_bloc/flutter_bloc.dart';
import '../../domain/usecases/calculate_loan_usecase.dart';
import 'calculator_event.dart';
import 'calculator_state.dart';

class CalculatorBloc extends Bloc<CalculatorEvent, CalculatorState> {
  final CalculateLoanUseCase calculateLoanUseCase;

  CalculatorBloc({required this.calculateLoanUseCase})
      : super(const CalculatorState()) {
    on<UpdateCalculatorValues>(_onUpdateCalculatorValues);
    on<CalculateLoan>(_onCalculateLoan);
  }

  void _onUpdateCalculatorValues(
    UpdateCalculatorValues event,
    Emitter<CalculatorState> emit,
  ) {
    emit(state.copyWith(
      amount: event.amount ?? state.amount,
      interestRate: event.interestRate ?? state.interestRate,
      duration: event.duration ?? state.duration,
      frequency: event.frequency ?? state.frequency,
      interestType: event.interestType ?? state.interestType,
    ));
  }

  Future<void> _onCalculateLoan(
    CalculateLoan event,
    Emitter<CalculatorState> emit,
  ) async {
    emit(state.copyWith(status: CalculatorStatus.loading));
    
    final result = await calculateLoanUseCase(
      CalculateLoanParams(
        amount: state.amount,
        interestRate: state.interestRate,
        interestType: state.interestType,
        frequency: state.frequency,
        duration: state.duration,
      ),
    );

    result.fold(
      (failure) => emit(state.copyWith(
        status: CalculatorStatus.error,
        errorMessage: failure.message,
      )),
      (calculation) => emit(state.copyWith(
        status: CalculatorStatus.success,
        calculation: calculation,
      )),
    );
  }
}
