import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../config/theme/app_colors.dart';
import '../../../../core/widgets/app_text.dart';
import '../../../../core/widgets/app_loader.dart';
import '../../../../di/injection_container.dart';
import '../bloc/expenses_bloc.dart';
import '../bloc/expenses_event.dart';
import '../bloc/expenses_state.dart';
import '../widgets/expense_summary_card.dart';
import '../widgets/expense_filter_bar.dart';
import '../widgets/expense_list_item.dart';
import '../widgets/add_expense_dialog.dart';

class ExpensesPage extends StatelessWidget {
  const ExpensesPage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => getIt<ExpensesBloc>()..add(LoadExpensesData()),
      child: const _ExpensesView(),
    );
  }
}

class _ExpensesView extends StatelessWidget {
  const _ExpensesView();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.scaffoldBackground,
      appBar: AppBar(
        title: const AppText.headlineSmall('Expense Register', color: AppColors.textHeading, fontWeight: FontWeight.bold),
        backgroundColor: AppColors.surfaceColor,
        elevation: 0,
      ),
      body: BlocBuilder<ExpensesBloc, ExpensesState>(
        builder: (context, state) {
          if (state.status == ExpensesStatus.loading || state.status == ExpensesStatus.initial) {
            return const Center(child: AppLoader());
          }
          if (state.status == ExpensesStatus.error) {
            return Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  AppText.bodyMedium(state.errorMessage ?? 'Error', color: AppColors.error),
                  TextButton(
                    onPressed: () => context.read<ExpensesBloc>().add(LoadExpensesData()),
                    child: const Text('Retry'),
                  ),
                ],
              ),
            );
          }

          // Calculate totals
          double totalOp = 0;
          for (var e in state.filteredExpenses) {
            totalOp += double.tryParse(e.amount) ?? 0;
          }
          double avg = state.filteredExpenses.isEmpty ? 0 : totalOp / state.filteredExpenses.length;

          return Stack(
            children: [
              RefreshIndicator(
                onRefresh: () async => context.read<ExpensesBloc>().add(LoadExpensesData()),
                child: ListView(
                  padding: const EdgeInsets.all(16),
                  children: [
                    Row(
                      children: [
                        ExpenseSummaryCard(
                          title: 'Operational',
                          icon: Icons.trending_up,
                          amount: '₹${totalOp.toStringAsFixed(0)}',
                          subtitle: '${state.filteredExpenses.length} entries',
                          baseColor: AppColors.error,
                        ),
                        const SizedBox(width: 12),
                        ExpenseSummaryCard(
                          title: 'Average',
                          icon: Icons.functions,
                          amount: '₹${avg.toStringAsFixed(0)}',
                          subtitle: 'Per entry',
                          baseColor: AppColors.primary,
                        ),
                      ],
                    ),
                    const SizedBox(height: 24),
                    const ExpenseFilterBar(),
                    const SizedBox(height: 24),
                    const Padding(
                      padding: EdgeInsets.only(left: 4, bottom: 12),
                      child: AppText.labelSmall('RECENT ENTRIES', color: AppColors.textCaption, fontWeight: FontWeight.bold),
                    ),
                    if (state.filteredExpenses.isEmpty)
                      const Padding(
                        padding: EdgeInsets.all(32),
                        child: Center(child: AppText.bodyMedium('No expenses found', color: AppColors.textCaption)),
                      )
                    else
                      ...state.filteredExpenses.map((expense) {
                        // Helper for icon based on category name
                        IconData icon = Icons.receipt;
                        Color iconColor = AppColors.primary;
                        final cName = expense.categoryName.toLowerCase();
                        if (cName.contains('fuel') || cName.contains('petrol')) {
                          icon = Icons.local_gas_station;
                          iconColor = AppColors.primary;
                        } else if (cName.contains('food')) {
                          icon = Icons.restaurant;
                          iconColor = AppColors.accent;
                        } else if (cName.contains('salary')) {
                          icon = Icons.work;
                          iconColor = AppColors.success;
                        }

                        return Padding(
                          padding: const EdgeInsets.only(bottom: 12),
                          child: ExpenseListItem(
                            icon: icon,
                            iconColor: iconColor,
                            title: expense.categoryName,
                            subtitle: '${expense.expenseDate} • ${expense.description.isNotEmpty ? expense.description : expense.categoryName}',
                            amount: '₹${expense.amount}',
                            paymentMethod: expense.paymentModeName ?? 'Unknown',
                            paymentMethodColor: (expense.paymentModeName ?? '').toLowerCase().contains('upi') ? AppColors.primary : AppColors.textCaption,
                          ),
                        );
                      }),
                    const SizedBox(height: 80), // Padding for FAB
                  ],
                ),
              ),
              Positioned(
                bottom: 24,
                right: 24,
                child: FloatingActionButton.extended(
                  onPressed: () => AddExpenseDialog.show(context),
                  backgroundColor: AppColors.primary,
                  foregroundColor: AppColors.textWhite,
                  icon: const Icon(Icons.add),
                  label: const Text('Add Expense', style: TextStyle(fontWeight: FontWeight.bold)),
                ),
              ),
            ],
          );
        },
      ),
    );
  }
}
