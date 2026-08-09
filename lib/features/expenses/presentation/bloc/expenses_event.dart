import 'package:equatable/equatable.dart';

import 'expenses_state.dart';

abstract class ExpensesEvent extends Equatable {
  const ExpensesEvent();

  @override
  List<Object?> get props => [];
}

class LoadExpensesData extends ExpensesEvent {}

class SubmitExpense extends ExpensesEvent {
  final int category;
  final String amount;
  final String expenseDate;
  final String description;
  final int paymentMode;

  const SubmitExpense({
    required this.category,
    required this.amount,
    required this.expenseDate,
    required this.description,
    required this.paymentMode,
  });

  @override
  List<Object?> get props => [category, amount, expenseDate, description, paymentMode];
}

class FilterExpensesBySearch extends ExpensesEvent {
  final String query;

  const FilterExpensesBySearch(this.query);

  @override
  List<Object> get props => [query];
}

class FilterExpensesByDate extends ExpensesEvent {
  final DateFilter filter;

  const FilterExpensesByDate(this.filter);

  @override
  List<Object> get props => [filter];
}
