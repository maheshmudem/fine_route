import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import '../../../../config/theme/app_colors.dart';
import '../../../../core/widgets/app_text.dart';
import '../../domain/entities/recent_collection.dart';

class RecentCollectionsSection extends StatelessWidget {
  final List<RecentCollection> collections;

  const RecentCollectionsSection({super.key, required this.collections});

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
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const AppText.bodyLarge('Recent Collections', color: AppColors.textHeading),
              TextButton(
                onPressed: () {},
                style: TextButton.styleFrom(
                  padding: EdgeInsets.zero,
                  minimumSize: const Size(50, 30),
                  tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                ),
                child: const AppText.labelSmall('View All', color: AppColors.primary),
              ),
            ],
          ),
          const SizedBox(height: 12),
          if (collections.isEmpty)
            const Padding(
              padding: EdgeInsets.symmetric(vertical: 20),
              child: Center(
                child: AppText.bodySmall('No recent collections', color: AppColors.textBody),
              ),
            )
          else
            ListView.separated(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              itemCount: collections.length,
              separatorBuilder: (context, index) => Divider(
                color: AppColors.border.withValues(alpha: 0.2),
                height: 24,
              ),
              itemBuilder: (context, index) {
                final collection = collections[index];
                return Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        AppText.bodyMedium(collection.customerName, color: AppColors.textHeading),
                        const SizedBox(height: 2),
                        AppText.bodySmall(
                          '${collection.customerCode} • ${collection.collectionDate}',
                          color: AppColors.textBody,
                        ),
                      ],
                    ),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: [
                        AppText.bodyMedium(
                          _formatCurrency(collection.collectedAmount),
                          color: Colors.green.shade700,
                          fontWeight: FontWeight.bold,
                        ),
                        const SizedBox(height: 2),
                        AppText.labelSmall(
                          collection.statusName.toUpperCase(),
                          color: Colors.green.shade600.withValues(alpha: 0.8),
                          fontWeight: FontWeight.bold,
                        ),
                      ],
                    ),
                  ],
                );
              },
            ),
        ],
      ),
    );
  }
}
