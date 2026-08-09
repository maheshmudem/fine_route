import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../../config/theme/app_colors.dart';
import '../../../../../core/widgets/app_text.dart';
import '../bloc/expenses_bloc.dart';
import '../bloc/expenses_event.dart';
import '../bloc/expenses_state.dart';

class ExpenseFilterBar extends StatelessWidget {
  const ExpenseFilterBar({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ExpensesBloc, ExpensesState>(
      builder: (context, state) {
        return Container(
          padding: const EdgeInsets.all(12),
          decoration: BoxDecoration(
            color: AppColors.surfaceColor,
            borderRadius: BorderRadius.circular(12),
            border: Border.all(color: AppColors.border),
            boxShadow: const [
              BoxShadow(color: AppColors.shadowColor, blurRadius: 4, offset: Offset(0, 2))
            ],
          ),
          child: Column(
            children: [
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 12),
                decoration: BoxDecoration(
                  color: AppColors.scaffoldBackground,
                  borderRadius: BorderRadius.circular(8),
                  border: Border.all(color: AppColors.border),
                ),
                child: Row(
                  children: [
                    const Icon(Icons.search, color: AppColors.iconColor, size: 20),
                    const SizedBox(width: 8),
                    Expanded(
                      child: TextField(
                        onChanged: (val) {
                          context.read<ExpensesBloc>().add(FilterExpensesBySearch(val));
                        },
                        decoration: const InputDecoration(
                          hintText: 'Search...',
                          hintStyle: TextStyle(color: AppColors.textCaption, fontSize: 14),
                          border: InputBorder.none,
                          isDense: true,
                          contentPadding: EdgeInsets.symmetric(vertical: 12),
                        ),
                        style: const TextStyle(color: AppColors.textHeading, fontSize: 14),
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 12),
              SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                child: Row(
                  children: [
                    _buildFilterChip(
                      'All Time',
                      icon: Icons.filter_list,
                      isActive: state.dateFilter == DateFilter.all,
                      onTap: () => context.read<ExpensesBloc>().add(const FilterExpensesByDate(DateFilter.all)),
                    ),
                    const SizedBox(width: 8),
                    _buildFilterChip(
                      'Today',
                      isActive: state.dateFilter == DateFilter.today,
                      onTap: () => context.read<ExpensesBloc>().add(const FilterExpensesByDate(DateFilter.today)),
                    ),
                    const SizedBox(width: 8),
                    _buildFilterChip(
                      'Week',
                      isActive: state.dateFilter == DateFilter.week,
                      onTap: () => context.read<ExpensesBloc>().add(const FilterExpensesByDate(DateFilter.week)),
                    ),
                    const SizedBox(width: 8),
                    _buildFilterChip(
                      'Month',
                      isActive: state.dateFilter == DateFilter.month,
                      onTap: () => context.read<ExpensesBloc>().add(const FilterExpensesByDate(DateFilter.month)),
                    ),
                    const SizedBox(width: 16),
                    GestureDetector(
                      onTap: () {
                        context.read<ExpensesBloc>().add(const FilterExpensesByDate(DateFilter.all));
                      },
                      child: Container(
                        padding: const EdgeInsets.all(6),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(8),
                        ),
                        child: const Icon(Icons.restart_alt, size: 20, color: AppColors.textCaption),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        );
      }
    );
  }

  Widget _buildFilterChip(String label, {IconData? icon, bool isActive = false, required VoidCallback onTap}) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
        decoration: BoxDecoration(
          color: isActive ? AppColors.primary.withValues(alpha: 0.1) : Colors.transparent,
          borderRadius: BorderRadius.circular(8),
          border: Border.all(color: isActive ? AppColors.primary.withValues(alpha: 0.2) : Colors.transparent),
        ),
        child: Row(
          children: [
            if (icon != null) ...[
              Icon(icon, size: 16, color: isActive ? AppColors.primary : AppColors.textCaption),
              const SizedBox(width: 4),
            ],
            AppText.labelSmall(
              label,
              fontWeight: FontWeight.w600,
              color: isActive ? AppColors.primary : AppColors.textCaption,
            ),
          ],
        ),
      ),
    );
  }
}
