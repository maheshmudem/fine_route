import 'package:flutter/material.dart';
import '../../../../../config/theme/app_colors.dart';
import '../../../../../core/widgets/app_text.dart';

class SettingsDropdownTile extends StatelessWidget {
  final String title;
  final String subtitle;
  final List<String> options;
  final String currentValue;
  final ValueChanged<String?> onChanged;

  const SettingsDropdownTile({
    super.key,
    required this.title,
    required this.subtitle,
    required this.options,
    required this.currentValue,
    required this.onChanged,
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
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 4),
            decoration: BoxDecoration(
              color: AppColors.scaffoldBackground,
              borderRadius: BorderRadius.circular(8),
              border: Border.all(color: AppColors.border),
            ),
            child: DropdownButtonHideUnderline(
              child: DropdownButton<String>(
                value: currentValue,
                icon: const Icon(Icons.expand_more, size: 20, color: AppColors.textCaption),
                isDense: true,
                style: const TextStyle(fontSize: 14, fontWeight: FontWeight.w500, color: AppColors.textHeading),
                onChanged: onChanged,
                items: options.map<DropdownMenuItem<String>>((String value) {
                  return DropdownMenuItem<String>(
                    value: value,
                    child: Text(value),
                  );
                }).toList(),
              ),
            ),
          )
        ],
      ),
    );
  }
}
