import 'package:flutter/material.dart';
import '../../config/theme/app_colors.dart';

/// A styled section header divider with title and optional icon.
///
/// Used by Edit Profile multi-section form and Family Member forms.
class SectionHeader extends StatelessWidget {
  /// The title text for the section.
  final String title;

  /// Optional leading icon.
  final IconData? icon;

  /// Optional trailing widget (e.g., action button).
  final Widget? trailing;

  const SectionHeader({
    super.key,
    required this.title,
    this.icon,
    this.trailing,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 24, bottom: 12),
      child: Row(
        children: [
          if (icon != null) ...[
            Icon(icon, size: 20, color: AppColors.primary),
            const SizedBox(width: 8),
          ],
          Expanded(
            child: Text(
              title,
              style: const TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.w700,
                fontFamily: 'Quicksand',
                color: AppColors.textHeading,
              ),
            ),
          ),
          ?trailing,
        ],
      ),
    );
  }
}
