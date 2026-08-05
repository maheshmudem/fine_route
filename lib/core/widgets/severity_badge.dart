import 'package:flutter/material.dart';
import '../../config/theme/app_colors.dart';

/// A colored chip badge for allergy severity.
///
/// - MILD → green
/// - MODERATE → amber
/// - SEVERE → red
class SeverityBadge extends StatelessWidget {
  /// The severity string (MILD, MODERATE, SEVERE).
  final String severity;

  /// Text size. Defaults to 11.
  final double fontSize;

  const SeverityBadge({
    super.key,
    required this.severity,
    this.fontSize = 11,
  });

  @override
  Widget build(BuildContext context) {
    final color = _colorFor(severity);
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
      decoration: BoxDecoration(
        color: color.withOpacity(0.12),
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: color.withOpacity(0.3)),
      ),
      child: Text(
        severity.toUpperCase(),
        style: TextStyle(
          fontSize: fontSize,
          fontWeight: FontWeight.w700,
          color: color,
          letterSpacing: 0.5,
        ),
      ),
    );
  }

  static Color _colorFor(String severity) {
    switch (severity.toUpperCase()) {
      case 'MILD':
        return AppColors.success;
      case 'MODERATE':
        return AppColors.warning;
      case 'SEVERE':
        return AppColors.error;
      default:
        return AppColors.textCaption;
    }
  }
}
