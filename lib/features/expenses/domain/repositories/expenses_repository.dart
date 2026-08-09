import 'package:dartz/dartz.dart';
import '../../../../core/error/failures.dart';
import '../entities/expense.dart';
import '../entities/expense_category.dart';
import '../entities/payment_mode.dart';

abstract class ExpensesRepository {
  Future<Either<Failure, List<Expense>>> getExpenses();
  Future<Either<Failure, List<ExpenseCategory>>> getExpenseCategories();
  Future<Either<Failure, List<PaymentMode>>> getPaymentModes();
  Future<Either<Failure, Expense>> addExpense(Map<String, dynamic> data);
}
