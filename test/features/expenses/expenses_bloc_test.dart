import 'package:bloc_test/bloc_test.dart';
import 'package:dartz/dartz.dart';
import 'package:fine_route/core/error/failures.dart';
import 'package:fine_route/core/usecase/usecase.dart';
import 'package:fine_route/features/expenses/domain/entities/expense.dart';
import 'package:fine_route/features/expenses/domain/entities/expense_category.dart';
import 'package:fine_route/features/expenses/domain/entities/payment_mode.dart';
import 'package:fine_route/features/expenses/domain/usecases/expenses_usecases.dart';
import 'package:fine_route/features/expenses/presentation/bloc/expenses_bloc.dart';
import 'package:fine_route/features/expenses/presentation/bloc/expenses_event.dart';
import 'package:fine_route/features/expenses/presentation/bloc/expenses_state.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

class MockGetExpensesUseCase extends Mock implements GetExpensesUseCase {}
class MockGetExpenseCategoriesUseCase extends Mock implements GetExpenseCategoriesUseCase {}
class MockGetPaymentModesUseCase extends Mock implements GetPaymentModesUseCase {}
class MockAddExpenseUseCase extends Mock implements AddExpenseUseCase {}

void main() {
  setUpAll(() {
    registerFallbackValue(const NoParams());
  });

  late ExpensesBloc bloc;
  late MockGetExpensesUseCase mockGetExpensesUseCase;
  late MockGetExpenseCategoriesUseCase mockGetExpenseCategoriesUseCase;
  late MockGetPaymentModesUseCase mockGetPaymentModesUseCase;
  late MockAddExpenseUseCase mockAddExpenseUseCase;

  setUp(() {
    mockGetExpensesUseCase = MockGetExpensesUseCase();
    mockGetExpenseCategoriesUseCase = MockGetExpenseCategoriesUseCase();
    mockGetPaymentModesUseCase = MockGetPaymentModesUseCase();
    mockAddExpenseUseCase = MockAddExpenseUseCase();

    bloc = ExpensesBloc(
      getExpensesUseCase: mockGetExpensesUseCase,
      getExpenseCategoriesUseCase: mockGetExpenseCategoriesUseCase,
      getPaymentModesUseCase: mockGetPaymentModesUseCase,
      addExpenseUseCase: mockAddExpenseUseCase,
    );
  });

  group('ExpensesBloc', () {
    final tExpenses = [
      Expense(
        publicId: '123',
        category: 1,
        categoryName: 'Fuel',
        amount: '500.0',
        expenseDate: '2026-08-09',
        description: '',
        createdAt: '2026-08-09T00:00:00',
      )
    ];
    final tCategories = [ExpenseCategory(id: 1, code: 'fuel', name: 'Fuel', isSystem: true)];
    final tPaymentModes = [PaymentMode(id: 1, code: 'cash', name: 'Cash', description: '', sortOrder: 1)];

    test('initial state is ExpensesState()', () {
      expect(bloc.state, const ExpensesState());
    });

    blocTest<ExpensesBloc, ExpensesState>(
      'emits [loading, success] when LoadExpensesData is successful',
      build: () {
        when(() => mockGetExpensesUseCase(any())).thenAnswer((_) async => Right(tExpenses));
        when(() => mockGetExpenseCategoriesUseCase(any())).thenAnswer((_) async => Right(tCategories));
        when(() => mockGetPaymentModesUseCase(any())).thenAnswer((_) async => Right(tPaymentModes));
        return bloc;
      },
      act: (bloc) => bloc.add(LoadExpensesData()),
      expect: () => [
        const ExpensesState(status: ExpensesStatus.loading),
        ExpensesState(
          status: ExpensesStatus.success,
          expenses: tExpenses,
          filteredExpenses: tExpenses,
          categories: tCategories,
          paymentModes: tPaymentModes,
        ),
      ],
    );

    blocTest<ExpensesBloc, ExpensesState>(
      'emits [error] when LoadExpensesData fails',
      build: () {
        when(() => mockGetExpensesUseCase(any())).thenAnswer((_) async => const Left(ServerFailure(message: 'Server error')));
        when(() => mockGetExpenseCategoriesUseCase(any())).thenAnswer((_) async => Right(tCategories));
        when(() => mockGetPaymentModesUseCase(any())).thenAnswer((_) async => Right(tPaymentModes));
        return bloc;
      },
      act: (bloc) => bloc.add(LoadExpensesData()),
      expect: () => [
        const ExpensesState(status: ExpensesStatus.loading),
        const ExpensesState(status: ExpensesStatus.error, errorMessage: 'Failed to fetch data'),
      ],
    );
  });
}
