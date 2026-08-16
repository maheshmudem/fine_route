import 'package:dartz/dartz.dart';
import '../../../../core/error/failures.dart';
import '../../domain/entities/expense.dart';
import '../../domain/entities/expense_category.dart';
import '../../domain/entities/payment_mode.dart';
import '../../domain/repositories/expenses_repository.dart';
import '../datasources/expenses_remote_data_source.dart';

class ExpensesRepositoryImpl implements ExpensesRepository {
  final ExpensesRemoteDataSource remoteDataSource;

  ExpensesRepositoryImpl(this.remoteDataSource);

  @override
  Future<Either<Failure, List<Expense>>> getExpenses({String? dateFrom, String? dateTo}) async {
    try {
      final remoteExpenses = await remoteDataSource.getExpenses(dateFrom: dateFrom, dateTo: dateTo);
      return Right(remoteExpenses);
    } catch (e) {
      return Left(ServerFailure(message: e.toString()));
    }
  }

  @override
  Future<Either<Failure, List<ExpenseCategory>>> getExpenseCategories() async {
    try {
      final data = await remoteDataSource.getExpenseCategories();
      return Right(data);
    } catch (e) {
      return Left(ServerFailure(message: e.toString()));
    }
  }

  @override
  Future<Either<Failure, List<PaymentMode>>> getPaymentModes() async {
    try {
      final data = await remoteDataSource.getPaymentModes();
      return Right(data);
    } catch (e) {
      return Left(ServerFailure(message: e.toString()));
    }
  }

  @override
  Future<Either<Failure, Expense>> addExpense(Map<String, dynamic> data) async {
    try {
      final response = await remoteDataSource.addExpense(data);
      return Right(response);
    } catch (e) {
      return Left(ServerFailure(message: e.toString()));
    }
  }
}
