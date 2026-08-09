import 'package:dartz/dartz.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../core/error/failures.dart';
import '../../../../core/usecase/usecase.dart';
import '../../domain/entities/expense.dart';
import '../../domain/entities/expense_category.dart';
import '../../domain/entities/payment_mode.dart';
import '../../domain/usecases/expenses_usecases.dart';
import 'expenses_event.dart';
import 'expenses_state.dart';

class ExpensesBloc extends Bloc<ExpensesEvent, ExpensesState> {
  final GetExpensesUseCase getExpensesUseCase;
  final GetExpenseCategoriesUseCase getExpenseCategoriesUseCase;
  final GetPaymentModesUseCase getPaymentModesUseCase;
  final AddExpenseUseCase addExpenseUseCase;

  ExpensesBloc({
    required this.getExpensesUseCase,
    required this.getExpenseCategoriesUseCase,
    required this.getPaymentModesUseCase,
    required this.addExpenseUseCase,
  }) : super(const ExpensesState()) {
    on<LoadExpensesData>(_onLoadExpensesData);
    on<SubmitExpense>(_onSubmitExpense);
    on<FilterExpensesBySearch>(_onFilterBySearch);
    on<FilterExpensesByDate>(_onFilterByDate);
  }

  Future<void> _onLoadExpensesData(LoadExpensesData event, Emitter<ExpensesState> emit) async {
    emit(state.copyWith(status: ExpensesStatus.loading));
    try {
      final expensesFuture = getExpensesUseCase(const NoParams());
      final categoriesFuture = getExpenseCategoriesUseCase(const NoParams());
      final paymentModesFuture = getPaymentModesUseCase(const NoParams());

      final results = await Future.wait([expensesFuture, categoriesFuture, paymentModesFuture]);

      final Either<Failure, List<Expense>> expensesResult = results[0] as Either<Failure, List<Expense>>;
      final Either<Failure, List<ExpenseCategory>> categoriesResult = results[1] as Either<Failure, List<ExpenseCategory>>;
      final Either<Failure, List<PaymentMode>> paymentModesResult = results[2] as Either<Failure, List<PaymentMode>>;

      if (expensesResult.isRight() && categoriesResult.isRight() && paymentModesResult.isRight()) {
        final expensesList = expensesResult.getOrElse(() => <Expense>[]);
        final filteredList = _applyFilters(expensesList, state.searchQuery, state.dateFilter);
        
        emit(state.copyWith(
          status: ExpensesStatus.success,
          expenses: expensesList,
          filteredExpenses: filteredList,
          categories: categoriesResult.getOrElse(() => <ExpenseCategory>[]),
          paymentModes: paymentModesResult.getOrElse(() => <PaymentMode>[]),
        ));
      } else {
        emit(state.copyWith(status: ExpensesStatus.error, errorMessage: 'Failed to fetch data'));
      }
    } catch (e) {
      emit(state.copyWith(status: ExpensesStatus.error, errorMessage: e.toString()));
    }
  }

  Future<void> _onSubmitExpense(SubmitExpense event, Emitter<ExpensesState> emit) async {
    emit(state.copyWith(status: ExpensesStatus.adding));
    try {
      final result = await addExpenseUseCase(AddExpenseParams(
        category: event.category,
        amount: event.amount,
        expenseDate: event.expenseDate,
        description: event.description,
        paymentMode: event.paymentMode,
      ));
      
      result.fold(
        (failure) => emit(state.copyWith(status: ExpensesStatus.addError, errorMessage: 'Failed to add expense')),
        (success) {
          emit(state.copyWith(status: ExpensesStatus.addSuccess));
          add(LoadExpensesData()); // Refresh list
        },
      );
    } catch (e) {
      emit(state.copyWith(status: ExpensesStatus.addError, errorMessage: e.toString()));
    }
  }

  void _onFilterBySearch(FilterExpensesBySearch event, Emitter<ExpensesState> emit) {
    final filtered = _applyFilters(state.expenses, event.query, state.dateFilter);
    emit(state.copyWith(
      searchQuery: event.query,
      filteredExpenses: filtered,
    ));
  }

  void _onFilterByDate(FilterExpensesByDate event, Emitter<ExpensesState> emit) {
    final filtered = _applyFilters(state.expenses, state.searchQuery, event.filter);
    emit(state.copyWith(
      dateFilter: event.filter,
      filteredExpenses: filtered,
    ));
  }

  List<Expense> _applyFilters(List<Expense> expenses, String query, DateFilter filter) {
    List<Expense> filtered = expenses;

    if (query.isNotEmpty) {
      final searchLower = query.toLowerCase();
      filtered = filtered.where((e) {
        return (e.categoryName.toLowerCase().contains(searchLower)) ||
            (e.description.toLowerCase().contains(searchLower)) ||
            ((e.paymentModeName ?? '').toLowerCase().contains(searchLower)) ||
            (e.amount.toLowerCase().contains(searchLower));
      }).toList();
    }

    final now = DateTime.now();
    switch (filter) {
      case DateFilter.all:
        break;
      case DateFilter.today:
        filtered = filtered.where((e) {
          final date = DateTime.tryParse(e.expenseDate);
          if (date == null) return false;
          return date.year == now.year && date.month == now.month && date.day == now.day;
        }).toList();
        break;
      case DateFilter.week:
        final startOfWeek = now.subtract(Duration(days: now.weekday - 1));
        filtered = filtered.where((e) {
          final date = DateTime.tryParse(e.expenseDate);
          if (date == null) return false;
          return date.isAfter(startOfWeek.subtract(const Duration(days: 1))) && date.isBefore(now.add(const Duration(days: 1)));
        }).toList();
        break;
      case DateFilter.month:
        filtered = filtered.where((e) {
          final date = DateTime.tryParse(e.expenseDate);
          if (date == null) return false;
          return date.year == now.year && date.month == now.month;
        }).toList();
        break;
    }

    return filtered;
  }
}

