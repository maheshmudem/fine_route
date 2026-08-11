import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import '../../../../config/theme/app_colors.dart';
import '../../../../core/widgets/app_text.dart';
import '../../domain/entities/dashboard_metrics.dart';

class DailyRouteCashSection extends StatelessWidget {
  final DashboardMetrics metrics;

  const DailyRouteCashSection({super.key, required this.metrics});

  String _formatCurrency(double amount) {
    return NumberFormat.currency(locale: 'en_IN', symbol: '₹', decimalDigits: 0).format(amount);
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        border: Border.all(color: AppColors.border.withValues(alpha: 0.6)),
        borderRadius: BorderRadius.circular(12),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.02),
            blurRadius: 6,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Container(
                padding: const EdgeInsets.all(6),
                decoration: BoxDecoration(
                  color: Colors.green.shade50,
                  borderRadius: BorderRadius.circular(6),
                ),
                child: Icon(Icons.payments, size: 18, color: Colors.green.shade700),
              ),
              const SizedBox(width: 8),
              const Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  AppText.labelSmall(
                    'DAILY ROUTE CASH',
                    color: AppColors.textHeading,
                    fontWeight: FontWeight.bold,
                  ),
                  AppText.bodySmall(
                    'Collections + Starting - (New Loans + Expenses)',
                    color: AppColors.textBody,
                  ),
                ],
              ),
            ],
          ),
          const SizedBox(height: 12),
          Row(
            children: [
              Expanded(
                child: Container(
                  padding: const EdgeInsets.all(8),
                  decoration: BoxDecoration(
                    color: Colors.green.shade50.withValues(alpha: 0.5),
                    borderRadius: BorderRadius.circular(8),
                    border: Border.all(color: Colors.green.shade100),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          AppText.bodySmall('Collections', color: Colors.green.shade800, fontWeight: FontWeight.w500),
                          Icon(Icons.arrow_upward, size: 14, color: Colors.green.shade600),
                        ],
                      ),
                      const SizedBox(height: 4),
                      AppText.headlineMedium(
                        _formatCurrency(metrics.amountCollectedToday),
                        color: Colors.green.shade700,
                        fontWeight: FontWeight.bold,
                      ),
                      const SizedBox(height: 2),
                      AppText.bodySmall('${metrics.collectionsToday} receipts', color: Colors.green.shade600.withValues(alpha: 0.8)),
                    ],
                  ),
                ),
              ),
              const SizedBox(width: 8),
              Expanded(
                child: Container(
                  padding: const EdgeInsets.all(8),
                  decoration: BoxDecoration(
                    color: Colors.red.shade50.withValues(alpha: 0.5),
                    borderRadius: BorderRadius.circular(8),
                    border: Border.all(color: Colors.red.shade100),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          AppText.bodySmall('Expenses', color: Colors.red.shade800, fontWeight: FontWeight.w500),
                          Icon(Icons.arrow_downward, size: 14, color: Colors.red.shade600),
                        ],
                      ),
                      const SizedBox(height: 4),
                      AppText.headlineMedium(
                        '-${_formatCurrency(metrics.expensesToday)}',
                        color: Colors.red.shade700,
                        fontWeight: FontWeight.bold,
                      ),
                      const SizedBox(height: 2),
                      AppText.bodySmall('${metrics.pendingToday} entries', color: Colors.red.shade600.withValues(alpha: 0.8)),
                    ],
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 12),
          Container(
            padding: const EdgeInsets.all(12),
            decoration: BoxDecoration(
              color: Colors.green.shade100.withValues(alpha: 0.5),
              borderRadius: BorderRadius.circular(8),
              border: Border.all(color: Colors.green.shade200),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        const Text('💰', style: TextStyle(fontSize: 14)),
                        const SizedBox(width: 4),
                        AppText.labelSmall('NET HANDHELD', color: Colors.green.shade900, fontWeight: FontWeight.bold),
                      ],
                    ),
                    const SizedBox(height: 2),
                    AppText.bodySmall('Physical cash in hand', color: Colors.green.shade700),
                  ],
                ),
                AppText.headlineLarge(
                  _formatCurrency(metrics.netCashToday),
                  color: Colors.green.shade800,
                  fontWeight: FontWeight.bold,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
