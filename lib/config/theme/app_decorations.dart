import 'package:flutter/material.dart';
import 'app_colors.dart';
import 'app_sizes.dart';

class AppDecorations {
  AppDecorations._();

  static BoxDecoration get card => const BoxDecoration(
        color: AppColors.cardBackground,
        borderRadius: AppSizes.brLg,
      );

  static BoxDecoration get primaryGradient => const BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [AppColors.primary, AppColors.primaryDark],
        ),
        borderRadius: AppSizes.brLg,
      );

  static BoxDecoration get primaryGradientFull => const BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [AppColors.primary, AppColors.primaryDark],
        ),
      );

  static BoxDecoration get secondaryGradient => const BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [AppColors.secondary, AppColors.secondaryDark],
        ),
        borderRadius: AppSizes.brLg,
      );

  static BoxDecoration get inputDecoration => BoxDecoration(
        color: AppColors.surfaceColor,
        borderRadius: AppSizes.brMd,
        border: Border.all(color: AppColors.border),
      );

  // Shadows should ideally be avoided in M3 in favor of SurfaceTint.
  // If custom shadows are needed, use these sparingly.
  static BoxShadow get defaultShadow => const BoxShadow(
        color: AppColors.shadowColor,
        blurRadius: 12,
        offset: Offset(0, 2),
      );

  static BoxShadow get elevatedShadow => const BoxShadow(
        color: AppColors.shadowColor,
        blurRadius: 20,
        offset: Offset(0, 6),
      );
}
