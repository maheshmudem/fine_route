import 'package:dartz/dartz.dart';
import '../../../../core/error/failures.dart';
import '../../../../core/usecase/usecase.dart';
import '../entities/expense.dart';
import '../entities/expense_category.dart';
import '../entities/payment_mode.dart';
import '../repositories/expenses_repository.dart';

class GetExpensesParams {
  final String? dateFrom;
  final String? dateTo;

  GetExpensesParams({this.dateFrom, this.dateTo});
}

class GetExpensesUseCase implements UseCase<List<Expense>, GetExpensesParams> {
  final ExpensesRepository repository;

  GetExpensesUseCase(this.repository);

  @override
  Future<Either<Failure, List<Expense>>> call(GetExpensesParams params) {
    return repository.getExpenses(dateFrom: params.dateFrom, dateTo: params.dateTo);
  }
}

class GetExpenseCategoriesUseCase implements UseCase<List<ExpenseCategory>, NoParams> {
  final ExpensesRepository repository;

  GetExpenseCategoriesUseCase(this.repository);

  @override
  Future<Either<Failure, List<ExpenseCategory>>> call(NoParams params) {
    return repository.getExpenseCategories();
  }
}

class GetPaymentModesUseCase implements UseCase<List<PaymentMode>, NoParams> {
  final ExpensesRepository repository;

  GetPaymentModesUseCase(this.repository);

  @override
  Future<Either<Failure, List<PaymentMode>>> call(NoParams params) {
    return repository.getPaymentModes();
  }
}

class AddExpenseParams {
  final int category;
  final String amount;
  final String expenseDate;
  final String description;
  final int paymentMode;

  AddExpenseParams({
    required this.category,
    required this.amount,
    required this.expenseDate,
    required this.description,
    required this.paymentMode,
  });

  Map<String, dynamic> toJson() => {
        'category': category,
        'amount': double.parse(amount), // assuming backend takes float or string, we parse if needed, payload showed number `500`
        'expense_date': expenseDate,
        'description': description,
        'payment_mode': paymentMode,
      };
}

class AddExpenseUseCase implements UseCase<Expense, AddExpenseParams> {
  final ExpensesRepository repository;

  AddExpenseUseCase(this.repository);

  @override
  Future<Either<Failure, Expense>> call(AddExpenseParams params) {
    return repository.addExpense(params.toJson());
  }
}
