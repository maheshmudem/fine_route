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
      final dates = _getDateRange(state.dateFilter);
      final expensesFuture = getExpensesUseCase(GetExpensesParams(dateFrom: dates.$1, dateTo: dates.$2));
      final categoriesFuture = getExpenseCategoriesUseCase(const NoParams());
      final paymentModesFuture = getPaymentModesUseCase(const NoParams());

      final results = await Future.wait([expensesFuture, categoriesFuture, paymentModesFuture]);

      final Either<Failure, List<Expense>> expensesResult = results[0] as Either<Failure, List<Expense>>;
      final Either<Failure, List<ExpenseCategory>> categoriesResult = results[1] as Either<Failure, List<ExpenseCategory>>;
      final Either<Failure, List<PaymentMode>> paymentModesResult = results[2] as Either<Failure, List<PaymentMode>>;

      if (expensesResult.isRight() && categoriesResult.isRight() && paymentModesResult.isRight()) {
        final expensesList = expensesResult.getOrElse(() => <Expense>[]);
        final filteredList = _applyFilters(expensesList, state.searchQuery);
        
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
    final filtered = _applyFilters(state.expenses, event.query);
    emit(state.copyWith(
      searchQuery: event.query,
      filteredExpenses: filtered,
    ));
  }

  Future<void> _onFilterByDate(FilterExpensesByDate event, Emitter<ExpensesState> emit) async {
    emit(state.copyWith(dateFilter: event.filter, status: ExpensesStatus.loading));
    
    final dates = _getDateRange(event.filter);
    final expensesResult = await getExpensesUseCase(GetExpensesParams(dateFrom: dates.$1, dateTo: dates.$2));
    
    expensesResult.fold(
      (failure) => emit(state.copyWith(status: ExpensesStatus.error, errorMessage: failure.message)),
      (expenses) {
        final filteredList = _applyFilters(expenses, state.searchQuery);
        emit(state.copyWith(
          status: ExpensesStatus.success,
          expenses: expenses,
          filteredExpenses: filteredList,
        ));
      }




    );
  }

  List<Expense> _applyFilters(List<Expense> expenses, String query) {
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

    return filtered;
  }

  (String?, String?) _getDateRange(DateFilter filter) {
    final now = DateTime.now();
    String formatDate(DateTime date) => 
        '${date.year.toString().padLeft(4, '0')}-${date.month.toString().padLeft(2, '0')}-${date.day.toString().padLeft(2, '0')}';

    switch (filter) {
      case DateFilter.all:
        return (null, null);
      case DateFilter.today:
        final todayStr = formatDate(now);
        return (todayStr, todayStr);
      case DateFilter.week:
        final startOfWeek = now.subtract(Duration(days: now.weekday - 1));
        final endOfWeek = now.add(Duration(days: 7 - now.weekday));
        return (formatDate(startOfWeek), formatDate(endOfWeek));
      case DateFilter.month:
        final startOfMonth = DateTime(now.year, now.month, 1);
        final endOfMonth = DateTime(now.year, now.month + 1, 0); // 0 gets the last day of the previous month, so month+1, 0 gets last day of current month.
        return (formatDate(startOfMonth), formatDate(endOfMonth));
    }
  }
}

