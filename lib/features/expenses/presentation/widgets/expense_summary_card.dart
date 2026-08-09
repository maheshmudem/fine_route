import 'package:flutter/material.dart';
import '../../../../../core/widgets/app_text.dart';

class ExpenseSummaryCard extends StatelessWidget {
  final String title;
  final IconData icon;
  final String amount;
  final String subtitle;
  final Color baseColor;

  const ExpenseSummaryCard({
    super.key,
    required this.title,
    required this.icon,
    required this.amount,
    required this.subtitle,
    required this.baseColor,
  });

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Container(
        padding: const EdgeInsets.all(12),
        decoration: BoxDecoration(
          color: baseColor.withValues(alpha: 0.05),
          borderRadius: BorderRadius.circular(12),
          border: Border.all(color: baseColor.withValues(alpha: 0.2)),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                AppText.labelSmall(
                  title.toUpperCase(),
                  color: baseColor,
                  fontWeight: FontWeight.bold,
                ),
                Icon(icon, color: baseColor.withValues(alpha: 0.5), size: 16),
              ],
            ),
            const SizedBox(height: 8),
            AppText.bodyLarge(amount, fontWeight: FontWeight.bold, color: baseColor),
            const SizedBox(height: 2),
            AppText.labelSmall(subtitle, color: baseColor.withValues(alpha: 0.8)),
          ],
        ),
      ),
    );
  }
}
