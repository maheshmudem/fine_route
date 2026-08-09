import 'package:flutter/material.dart';
import '../../../../../config/theme/app_colors.dart';
import '../../../../../core/widgets/app_text.dart';

class SettingsActionTile extends StatelessWidget {
  final String title;
  final String subtitle;
  final IconData? icon;
  final String buttonText;
  final VoidCallback onPressed;
  final bool isDestructive;

  const SettingsActionTile({
    super.key,
    required this.title,
    required this.subtitle,
    this.icon,
    required this.buttonText,
    required this.onPressed,
    this.isDestructive = false,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                AppText.bodyLarge(title, fontWeight: FontWeight.w600, color: AppColors.textHeading),
                AppText.bodySmall(subtitle, color: AppColors.textCaption),
              ],
            ),
          ),
          ElevatedButton(
            onPressed: onPressed,
            style: ElevatedButton.styleFrom(
              backgroundColor: isDestructive ? AppColors.error : AppColors.cardBackground,
              foregroundColor: isDestructive ? AppColors.textWhite : AppColors.textHeading,
              elevation: 0,
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 0),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(8),
                side: BorderSide(color: isDestructive ? Colors.transparent : AppColors.border),
              ),
            ),
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                if (icon != null) ...[
                  Icon(icon, size: 18),
                  const SizedBox(width: 4),
                ],
                Text(buttonText, style: const TextStyle(fontSize: 14, fontWeight: FontWeight.w600)),
              ],
            ),
          )
        ],
      ),
    );
  }
}
