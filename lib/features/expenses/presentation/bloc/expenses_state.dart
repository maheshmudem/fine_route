import 'package:equatable/equatable.dart';
import '../../domain/entities/expense.dart';
import '../../domain/entities/expense_category.dart';
import '../../domain/entities/payment_mode.dart';

enum ExpensesStatus { initial, loading, success, error, adding, addSuccess, addError }

enum DateFilter { all, today, week, month }

class ExpensesState extends Equatable {
  final ExpensesStatus status;
  final List<Expense> expenses;
  final List<Expense> filteredExpenses;
  final List<ExpenseCategory> categories;
  final List<PaymentMode> paymentModes;
  final String? errorMessage;
  final String searchQuery;
  final DateFilter dateFilter;

  const ExpensesState({
    this.status = ExpensesStatus.initial,
    this.expenses = const [],
    this.filteredExpenses = const [],
    this.categories = const [],
    this.paymentModes = const [],
    this.errorMessage,
    this.searchQuery = '',
    this.dateFilter = DateFilter.all,
  });

  ExpensesState copyWith({
    ExpensesStatus? status,
    List<Expense>? expenses,
    List<Expense>? filteredExpenses,
    List<ExpenseCategory>? categories,
    List<PaymentMode>? paymentModes,
    String? errorMessage,
    String? searchQuery,
    DateFilter? dateFilter,
  }) {
    return ExpensesState(
      status: status ?? this.status,
      expenses: expenses ?? this.expenses,
      filteredExpenses: filteredExpenses ?? this.filteredExpenses,
      categories: categories ?? this.categories,
      paymentModes: paymentModes ?? this.paymentModes,
      errorMessage: errorMessage ?? this.errorMessage,
      searchQuery: searchQuery ?? this.searchQuery,
      dateFilter: dateFilter ?? this.dateFilter,
    );
  }

  @override
  List<Object?> get props => [status, expenses, filteredExpenses, categories, paymentModes, errorMessage, searchQuery, dateFilter];
}
