import 'package:flutter/material.dart';
import '../../../../../config/theme/app_colors.dart';
import '../../../../../core/widgets/app_text.dart';

class UpgradeFeatureRow extends StatelessWidget {
  final IconData icon;
  final Color color;
  final String title;
  final String description;

  const UpgradeFeatureRow({
    super.key,
    required this.icon,
    required this.color,
    required this.title,
    required this.description,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: AppColors.cardBackground,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: AppColors.border),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            padding: const EdgeInsets.all(8),
            decoration: BoxDecoration(
              color: color.withValues(alpha: 0.1),
              shape: BoxShape.circle,
            ),
            child: Icon(icon, color: color, size: 24),
          ),
          const SizedBox(width: 16),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                AppText.bodyMedium(title, fontWeight: FontWeight.bold, color: AppColors.textHeading),
                const SizedBox(height: 4),
                AppText.bodySmall(description, color: AppColors.textCaption),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
