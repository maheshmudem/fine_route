import 'package:flutter/material.dart';
import 'app_colors.dart';
import 'app_sizes.dart';
import 'app_text_styles.dart';

class AppTheme {
  AppTheme._();

  static ThemeData get lightTheme {
    const colorScheme = ColorScheme(
      brightness: Brightness.light,
      primary: AppColors.primary,
      onPrimary: Colors.white,
      primaryContainer: AppColors.primaryLight,
      onPrimaryContainer: Colors.white,
      secondary: AppColors.secondary,
      onSecondary: Colors.white,
      secondaryContainer: AppColors.secondaryLight,
      onSecondaryContainer: Colors.white,
      tertiary: AppColors.accent,
      onTertiary: Colors.white,
      tertiaryContainer: AppColors.accentLight,
      onTertiaryContainer: AppColors.textHeading,
      error: AppColors.error,
      onError: Colors.white,
      surface: AppColors.surfaceColor,
      onSurface: AppColors.textHeading,
      onSurfaceVariant: AppColors.textBody,
      outline: AppColors.border,
      outlineVariant: AppColors.divider,
      shadow: AppColors.shadowColor,
    );

    final textTheme = TextTheme(
      displayLarge: AppTextStyles.displayLarge.copyWith(color: colorScheme.onSurface),
      displayMedium: AppTextStyles.displayMedium.copyWith(color: colorScheme.onSurface),
      displaySmall: AppTextStyles.displaySmall.copyWith(color: colorScheme.onSurface),
      headlineLarge: AppTextStyles.headlineLarge.copyWith(color: colorScheme.onSurface),
      headlineMedium: AppTextStyles.headlineMedium.copyWith(color: colorScheme.onSurface),
      headlineSmall: AppTextStyles.headlineSmall.copyWith(color: colorScheme.onSurface),
      titleLarge: AppTextStyles.titleLarge.copyWith(color: colorScheme.onSurface),
      titleMedium: AppTextStyles.titleMedium.copyWith(color: colorScheme.onSurface),
      titleSmall: AppTextStyles.titleSmall.copyWith(color: colorScheme.onSurface),
      bodyLarge: AppTextStyles.bodyLarge.copyWith(color: colorScheme.onSurfaceVariant),
      bodyMedium: AppTextStyles.bodyMedium.copyWith(color: colorScheme.onSurfaceVariant),
      bodySmall: AppTextStyles.bodySmall.copyWith(color: colorScheme.onSurfaceVariant),
      labelLarge: AppTextStyles.labelLarge.copyWith(color: colorScheme.onSurfaceVariant),
      labelMedium: AppTextStyles.labelMedium.copyWith(color: colorScheme.onSurfaceVariant),
      labelSmall: AppTextStyles.labelSmall.copyWith(color: colorScheme.onSurfaceVariant),
    );

    return ThemeData(
      useMaterial3: true,
      colorScheme: colorScheme,
      scaffoldBackgroundColor: AppColors.scaffoldBackground,
      primaryColor: AppColors.primary,
      textTheme: textTheme,
      
      appBarTheme: AppBarTheme(
        backgroundColor: colorScheme.surface,
        foregroundColor: colorScheme.onSurface,
        elevation: 0,
        centerTitle: false,
        titleTextStyle: textTheme.titleLarge,
        iconTheme: IconThemeData(color: colorScheme.onSurface),
      ),

      cardTheme: CardThemeData(
        color: colorScheme.surface,
        elevation: 0,
        shape: const RoundedRectangleBorder(borderRadius: AppSizes.brLg),
        margin: EdgeInsets.zero,
      ),

      elevatedButtonTheme: ElevatedButtonThemeData(
        style: ElevatedButton.styleFrom(
          backgroundColor: colorScheme.primary,
          foregroundColor: colorScheme.onPrimary,
          shape: const RoundedRectangleBorder(borderRadius: AppSizes.brMd),
          minimumSize: const Size(AppSizes.minTouchTarget, AppSizes.minTouchTarget),
          elevation: 2,
          textStyle: AppTextStyles.buttonText,
          padding: const EdgeInsets.symmetric(horizontal: AppSizes.p24, vertical: AppSizes.p12),
        ),
      ),

      outlinedButtonTheme: OutlinedButtonThemeData(
        style: OutlinedButton.styleFrom(
          foregroundColor: colorScheme.primary,
          side: BorderSide(color: colorScheme.primary),
          shape: const RoundedRectangleBorder(borderRadius: AppSizes.brMd),
          minimumSize: const Size(AppSizes.minTouchTarget, AppSizes.minTouchTarget),
          textStyle: AppTextStyles.buttonText,
          padding: const EdgeInsets.symmetric(horizontal: AppSizes.p24, vertical: AppSizes.p12),
        ),
      ),

      textButtonTheme: TextButtonThemeData(
        style: TextButton.styleFrom(
          foregroundColor: colorScheme.primary,
          minimumSize: const Size(AppSizes.minTouchTarget, AppSizes.minTouchTarget),
          textStyle: AppTextStyles.buttonText,
          padding: const EdgeInsets.symmetric(horizontal: AppSizes.p16, vertical: AppSizes.p8),
        ),
      ),

      inputDecorationTheme: InputDecorationTheme(
        filled: true,
        fillColor: colorScheme.surface,
        contentPadding: const EdgeInsets.symmetric(horizontal: AppSizes.p16, vertical: AppSizes.p16),
        border: OutlineInputBorder(
          borderRadius: AppSizes.brMd,
          borderSide: BorderSide(color: colorScheme.outline),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: AppSizes.brMd,
          borderSide: BorderSide(color: colorScheme.outline),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: AppSizes.brMd,
          borderSide: BorderSide(color: colorScheme.primary, width: 2),
        ),
        errorBorder: OutlineInputBorder(
          borderRadius: AppSizes.brMd,
          borderSide: BorderSide(color: colorScheme.error),
        ),
        labelStyle: textTheme.bodyMedium,
        hintStyle: textTheme.bodyMedium?.copyWith(color: AppColors.textCaption),
      ),

      bottomNavigationBarTheme: BottomNavigationBarThemeData(
        backgroundColor: colorScheme.surface,
        selectedItemColor: colorScheme.primary,
        unselectedItemColor: AppColors.textCaption,
        selectedLabelStyle: textTheme.labelMedium?.copyWith(fontWeight: FontWeight.w600),
        unselectedLabelStyle: textTheme.labelSmall,
        type: BottomNavigationBarType.fixed,
        elevation: 8,
      ),

      dividerTheme: DividerThemeData(
        color: colorScheme.outlineVariant,
        thickness: 1,
        space: 1,
      ),

      chipTheme: ChipThemeData(
        backgroundColor: colorScheme.surface,
        labelStyle: textTheme.labelLarge,
        shape: const RoundedRectangleBorder(borderRadius: AppSizes.brSm),
        side: BorderSide(color: colorScheme.outlineVariant),
      ),

      dialogTheme: DialogThemeData(
        backgroundColor: colorScheme.surface,
        shape: const RoundedRectangleBorder(borderRadius: AppSizes.brLg),
        titleTextStyle: textTheme.headlineSmall,
        contentTextStyle: textTheme.bodyMedium,
      ),

      bottomSheetTheme: BottomSheetThemeData(
        backgroundColor: colorScheme.surface,
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.vertical(top: Radius.circular(AppSizes.radiusLg)),
        ),
      ),

      floatingActionButtonTheme: FloatingActionButtonThemeData(
        backgroundColor: colorScheme.secondary,
        foregroundColor: colorScheme.onSecondary,
        shape: const RoundedRectangleBorder(borderRadius: AppSizes.brLg),
      ),

      snackBarTheme: SnackBarThemeData(
        backgroundColor: colorScheme.onSurface,
        contentTextStyle: textTheme.bodyMedium?.copyWith(color: colorScheme.surface),
        shape: const RoundedRectangleBorder(borderRadius: AppSizes.brSm),
        behavior: SnackBarBehavior.floating,
      ),
      
      checkboxTheme: CheckboxThemeData(
        fillColor: WidgetStateProperty.resolveWith<Color>((states) {
          if (states.contains(WidgetState.disabled)) return colorScheme.onSurface.withValues(alpha: 0.38);
          if (states.contains(WidgetState.selected)) return colorScheme.primary;
          return Colors.transparent;
        }),
        shape: const RoundedRectangleBorder(borderRadius: BorderRadius.all(Radius.circular(4))),
      ),
      
      radioTheme: RadioThemeData(
        fillColor: WidgetStateProperty.resolveWith<Color>((states) {
          if (states.contains(WidgetState.disabled)) return colorScheme.onSurface.withValues(alpha: 0.38);
          if (states.contains(WidgetState.selected)) return colorScheme.primary;
          return colorScheme.onSurfaceVariant;
        }),
      ),
      
      switchTheme: SwitchThemeData(
        thumbColor: WidgetStateProperty.resolveWith<Color>((states) {
          if (states.contains(WidgetState.disabled)) return colorScheme.onSurface.withValues(alpha: 0.38);
          if (states.contains(WidgetState.selected)) return colorScheme.primary;
          return colorScheme.outline;
        }),
        trackColor: WidgetStateProperty.resolveWith<Color>((states) {
          if (states.contains(WidgetState.disabled)) return colorScheme.onSurface.withValues(alpha: 0.12);
          if (states.contains(WidgetState.selected)) return colorScheme.primary.withValues(alpha: 0.5);
          return colorScheme.surface.withValues(alpha: 0.5); // Fallback color that exists
        }),
      ),
    );
  }

  static ThemeData get darkTheme {
    return ThemeData(
      useMaterial3: true,
      colorScheme: ColorScheme.fromSeed(
        seedColor: AppColors.primary,
        brightness: Brightness.dark,
        primary: AppColors.primaryLight,
        secondary: AppColors.secondaryLight,
        tertiary: AppColors.accentLight,
      ),
      scaffoldBackgroundColor: const Color(0xFF121212),
    );
  }
}
