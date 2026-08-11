import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import '../../../../config/theme/app_colors.dart';
import '../../../../core/widgets/app_text.dart';
import '../../domain/entities/dashboard_metrics.dart';

class MetricGridSection extends StatelessWidget {
  final DashboardMetrics metrics;

  const MetricGridSection({super.key, required this.metrics});

  String _formatCurrency(double amount) {
    return NumberFormat.currency(locale: 'en_IN', symbol: '₹', decimalDigits: 0).format(amount);
  }

  @override
  Widget build(BuildContext context) {
    return GridView.count(
      crossAxisCount: 2,
      crossAxisSpacing: 12,
      mainAxisSpacing: 12,
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      childAspectRatio: 1.5,
      children: [
        _MetricCard(
          title: 'Collections (Today)',
          amount: _formatCurrency(metrics.amountCollectedToday),
          subtitle: '${metrics.collectionsToday} receipts',
          icon: Icons.account_balance_wallet,
          color: Colors.blue,
        ),
        _MetricCard(
          title: 'Expenses (Today)',
          amount: _formatCurrency(metrics.expensesToday),
          subtitle: '${metrics.pendingToday} vouchers',
          icon: Icons.receipt_long,
          color: Colors.red,
        ),
        _MetricCard(
          title: 'Net Cash (Today)',
          amount: _formatCurrency(metrics.netCashToday),
          subtitle: 'Gross - expenses',
          icon: Icons.currency_rupee,
          color: Colors.indigo,
          isPrimaryText: true,
        ),
        _MetricCard(
          title: 'Total Outstanding',
          amount: _formatCurrency(metrics.outstandingBalance),
          subtitle: '${metrics.activeLoans} active loans',
          icon: Icons.pie_chart,
          color: CustomColors.slate,
        ),
      ],
    );
  }
}

class _MetricCard extends StatelessWidget {
  final String title;
  final String amount;
  final String subtitle;
  final IconData icon;
  final MaterialColor color;
  final bool isPrimaryText;

  const _MetricCard({
    required this.title,
    required this.amount,
    required this.subtitle,
    required this.icon,
    required this.color,
    this.isPrimaryText = false,
  });

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
      padding: const EdgeInsets.all(12),
      child: Stack(
        clipBehavior: Clip.none,
        children: [
          Positioned(
            right: -20,
            top: -20,
            child: CircleAvatar(
              radius: 30,
              backgroundColor: color.shade50.withValues(alpha: 0.5),
            ),
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  AppText.labelSmall(
                    title.toUpperCase(),
                    color: AppColors.textBody,
                    fontWeight: FontWeight.bold,
                  ),
                  const SizedBox(height: 4),
                  AppText.titleLarge(
                    amount,
                    color: isPrimaryText ? AppColors.primary : AppColors.textHeading,
                    fontWeight: FontWeight.bold,
                  ),
                ],
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  AppText.bodySmall(
                    subtitle,
                    color: AppColors.textBody,
                  ),
                  Container(
                    width: 28,
                    height: 28,
                    decoration: BoxDecoration(
                      color: color.shade50,
                      shape: BoxShape.circle,
                    ),
                    child: Icon(icon, size: 16, color: color.shade600),
                  ),
                ],
              ),
            ],
          ),
        ],
      ),
    );
  }
}

class CustomColors {
  static const MaterialColor slate = MaterialColor(
    0xFF64748B,
    <int, Color>{
      50: Color(0xFFF8FAFC),
      100: Color(0xFFF1F5F9),
      200: Color(0xFFE2E8F0),
      300: Color(0xFFCBD5E1),
      400: Color(0xFF94A3B8),
      500: Color(0xFF64748B),
      600: Color(0xFF475569),
      700: Color(0xFF334155),
      800: Color(0xFF1E293B),
      900: Color(0xFF0F172A),
    },
  );
}
