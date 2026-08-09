import 'package:bloc_test/bloc_test.dart';
import 'package:fine_route/core/widgets/app_loader.dart';
import 'package:fine_route/features/expenses/domain/entities/expense.dart';
import 'package:fine_route/features/expenses/presentation/bloc/expenses_bloc.dart';
import 'package:fine_route/features/expenses/presentation/bloc/expenses_event.dart';
import 'package:fine_route/features/expenses/presentation/bloc/expenses_state.dart';
import 'package:fine_route/features/expenses/presentation/pages/expenses_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:get_it/get_it.dart';
import 'package:mocktail/mocktail.dart';

class MockExpensesBloc extends MockBloc<ExpensesEvent, ExpensesState> implements ExpensesBloc {}

void main() {
  late MockExpensesBloc mockExpensesBloc;

  setUpAll(() {
    registerFallbackValue(LoadExpensesData());
  });

  setUp(() {
    mockExpensesBloc = MockExpensesBloc();
    
    // Reset GetIt and register mock bloc
    if (GetIt.I.isRegistered<ExpensesBloc>()) {
      GetIt.I.unregister<ExpensesBloc>();
    }
    GetIt.I.registerFactory<ExpensesBloc>(() => mockExpensesBloc);
  });

  tearDown(() {
    GetIt.I.reset();
  });

  Widget buildTestableWidget(Widget widget) {
    return MaterialApp(
      home: widget,
    );
  }

  testWidgets('ExpensesPage displays loading state', (WidgetTester tester) async {
    when(() => mockExpensesBloc.state).thenReturn(const ExpensesState(status: ExpensesStatus.loading));

    await tester.pumpWidget(buildTestableWidget(const ExpensesPage()));

    expect(find.byType(AppLoader), findsOneWidget);
  });

  testWidgets('ExpensesPage displays error state', (WidgetTester tester) async {
    when(() => mockExpensesBloc.state).thenReturn(
      const ExpensesState(status: ExpensesStatus.error, errorMessage: 'Failed to fetch data'),
    );

    await tester.pumpWidget(buildTestableWidget(const ExpensesPage()));
    await tester.pumpAndSettle();

    expect(find.text('Failed to fetch data'), findsOneWidget);
    expect(find.text('Retry'), findsOneWidget);
  });

  testWidgets('ExpensesPage displays data when success', (WidgetTester tester) async {
    final tExpenses = [
      Expense(
        publicId: '123',
        category: 1,
        categoryName: 'Fuel',
        amount: '500.0',
        expenseDate: '2026-08-09',
        description: 'Test Expense',
        createdAt: '2026-08-09T00:00:00',
        paymentModeName: 'Cash',
      )
    ];

    when(() => mockExpensesBloc.state).thenReturn(
      ExpensesState(
        status: ExpensesStatus.success,
        expenses: tExpenses,
        filteredExpenses: tExpenses,
        categories: const [],
        paymentModes: const [],
      ),
    );

    await tester.pumpWidget(buildTestableWidget(const ExpensesPage()));
    await tester.pumpAndSettle();

    expect(find.text('Fuel'), findsWidgets);
    expect(find.text('₹500.0'), findsWidgets);
    expect(find.text('OPERATIONAL'), findsWidgets);
  });
}
