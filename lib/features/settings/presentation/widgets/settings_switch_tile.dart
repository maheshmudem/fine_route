import 'package:flutter/material.dart';
import '../../../../../config/theme/app_colors.dart';
import '../../../../../core/widgets/app_text.dart';

class SettingsSwitchTile extends StatelessWidget {
  final String title;
  final String? subtitle;
  final bool value;
  final ValueChanged<bool> onChanged;

  const SettingsSwitchTile({
    super.key,
    required this.title,
    this.subtitle,
    required this.value,
    required this.onChanged,
  });

  @override
  Widget build(BuildContext context) {
    return SwitchListTile.adaptive(
      contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 4),
      title: AppText.bodyLarge(title, fontWeight: FontWeight.w600, color: AppColors.textHeading),
      subtitle: subtitle != null ? AppText.bodySmall(subtitle!, color: AppColors.textCaption) : null,
      value: value,
      activeTrackColor: AppColors.primary,
      onChanged: onChanged,
    );
  }
}
