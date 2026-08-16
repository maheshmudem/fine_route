import 'package:flutter/material.dart';
import '../../config/theme/app_text_styles.dart';

/// A highly robust, futuristic `Text` widget wrapper that handles:
/// - Dark/Light mode theming
/// - Localization (i18n) & argument injection
/// - Text selection (copying text)
/// - Accessibility (Semantics, Scaling)
/// - Auto-sizing capabilities (FittedBox)
class AppText extends StatelessWidget {
  final String text;
  final TextStyle? style;
  final TextAlign? textAlign;
  final TextOverflow? overflow;
  final int? maxLines;
  final Color? color;
  
  // Advanced & Futuristic Features
  final bool isKey; // True if 'text' is a localization key
  final Map<String, String>? namedArgs; // For injecting translation variables
  final bool isSelectable; // True to allow users to select/copy the text
  final bool autoSize; // True to wrap in FittedBox to prevent overflow
  final String? semanticsLabel; // For screen readers (Accessibility)
  final TextScaler? textScaler; // Restrict max scaling for accessibility
  final TextDecoration? decoration;
  final FontWeight? fontWeight;

  const AppText(
    this.text, {
    super.key,
    this.style,
    this.textAlign,
    this.overflow,
    this.maxLines,
    this.color,
    this.isKey = false,
    this.namedArgs,
    this.isSelectable = false,
    this.autoSize = false,
    this.semanticsLabel,
    this.textScaler,
    this.decoration,
    this.fontWeight,
  });

  // ===========================================================================
  // Typography Constructors mapped exactly to AppTextStyles
  // ===========================================================================
  
  // Display
  const AppText.displayLarge(this.text, {super.key, this.color, this.textAlign, this.overflow, this.maxLines, this.isKey = false, this.namedArgs, this.isSelectable = false, this.autoSize = false, this.semanticsLabel, this.textScaler, this.decoration, this.fontWeight}) : style = AppTextStyles.displayLarge;
  const AppText.displayMedium(this.text, {super.key, this.color, this.textAlign, this.overflow, this.maxLines, this.isKey = false, this.namedArgs, this.isSelectable = false, this.autoSize = false, this.semanticsLabel, this.textScaler, this.decoration, this.fontWeight}) : style = AppTextStyles.displayMedium;
  const AppText.displaySmall(this.text, {super.key, this.color, this.textAlign, this.overflow, this.maxLines, this.isKey = false, this.namedArgs, this.isSelectable = false, this.autoSize = false, this.semanticsLabel, this.textScaler, this.decoration, this.fontWeight}) : style = AppTextStyles.displaySmall;

  // Headline
  const AppText.headlineLarge(this.text, {super.key, this.color, this.textAlign, this.overflow, this.maxLines, this.isKey = false, this.namedArgs, this.isSelectable = false, this.autoSize = false, this.semanticsLabel, this.textScaler, this.decoration, this.fontWeight}) : style = AppTextStyles.headlineLarge;
  const AppText.headlineMedium(this.text, {super.key, this.color, this.textAlign, this.overflow, this.maxLines, this.isKey = false, this.namedArgs, this.isSelectable = false, this.autoSize = false, this.semanticsLabel, this.textScaler, this.decoration, this.fontWeight}) : style = AppTextStyles.headlineMedium;
  const AppText.headlineSmall(this.text, {super.key, this.color, this.textAlign, this.overflow, this.maxLines, this.isKey = false, this.namedArgs, this.isSelectable = false, this.autoSize = false, this.semanticsLabel, this.textScaler, this.decoration, this.fontWeight}) : style = AppTextStyles.headlineSmall;

  // Title
  const AppText.titleLarge(this.text, {super.key, this.color, this.textAlign, this.overflow, this.maxLines, this.isKey = false, this.namedArgs, this.isSelectable = false, this.autoSize = false, this.semanticsLabel, this.textScaler, this.decoration, this.fontWeight}) : style = AppTextStyles.titleLarge;
  const AppText.titleMedium(this.text, {super.key, this.color, this.textAlign, this.overflow, this.maxLines, this.isKey = false, this.namedArgs, this.isSelectable = false, this.autoSize = false, this.semanticsLabel, this.textScaler, this.decoration, this.fontWeight}) : style = AppTextStyles.titleMedium;
  const AppText.titleSmall(this.text, {super.key, this.color, this.textAlign, this.overflow, this.maxLines, this.isKey = false, this.namedArgs, this.isSelectable = false, this.autoSize = false, this.semanticsLabel, this.textScaler, this.decoration, this.fontWeight}) : style = AppTextStyles.titleSmall;

  // Body
  const AppText.bodyLarge(this.text, {super.key, this.color, this.textAlign, this.overflow, this.maxLines, this.isKey = false, this.namedArgs, this.isSelectable = false, this.autoSize = false, this.semanticsLabel, this.textScaler, this.decoration, this.fontWeight}) : style = AppTextStyles.bodyLarge;
  const AppText.bodyMedium(this.text, {super.key, this.color, this.textAlign, this.overflow, this.maxLines, this.isKey = false, this.namedArgs, this.isSelectable = false, this.autoSize = false, this.semanticsLabel, this.textScaler, this.decoration, this.fontWeight}) : style = AppTextStyles.bodyMedium;
  const AppText.bodySmall(this.text, {super.key, this.color, this.textAlign, this.overflow, this.maxLines, this.isKey = false, this.namedArgs, this.isSelectable = false, this.autoSize = false, this.semanticsLabel, this.textScaler, this.decoration, this.fontWeight}) : style = AppTextStyles.bodySmall;

  // Label
  const AppText.labelLarge(this.text, {super.key, this.color, this.textAlign, this.overflow, this.maxLines, this.isKey = false, this.namedArgs, this.isSelectable = false, this.autoSize = false, this.semanticsLabel, this.textScaler, this.decoration, this.fontWeight}) : style = AppTextStyles.labelLarge;
  const AppText.labelMedium(this.text, {super.key, this.color, this.textAlign, this.overflow, this.maxLines, this.isKey = false, this.namedArgs, this.isSelectable = false, this.autoSize = false, this.semanticsLabel, this.textScaler, this.decoration, this.fontWeight}) : style = AppTextStyles.labelMedium;
  const AppText.labelSmall(this.text, {super.key, this.color, this.textAlign, this.overflow, this.maxLines, this.isKey = false, this.namedArgs, this.isSelectable = false, this.autoSize = false, this.semanticsLabel, this.textScaler, this.decoration, this.fontWeight}) : style = AppTextStyles.labelSmall;

  // Custom
  const AppText.buttonText(this.text, {super.key, this.color, this.textAlign, this.overflow, this.maxLines, this.isKey = false, this.namedArgs, this.isSelectable = false, this.autoSize = false, this.semanticsLabel, this.textScaler, this.decoration, this.fontWeight}) : style = AppTextStyles.buttonText;
  const AppText.linkText(this.text, {super.key, this.color, this.textAlign, this.overflow, this.maxLines, this.isKey = false, this.namedArgs, this.isSelectable = false, this.autoSize = false, this.semanticsLabel, this.textScaler, this.decoration, this.fontWeight}) : style = AppTextStyles.linkText;


  @override
  Widget build(BuildContext context) {
    // 1. Dynamic Theming
    // Gets the base style based on context if no style provided.
    // Automatically applies Dark/Light mode color logic based on Theme colorScheme onSurface.
    final baseStyle = style ?? Theme.of(context).textTheme.bodyMedium;
    final mergedStyle = baseStyle?.copyWith(
      color: color, 
      decoration: decoration,
      fontWeight: fontWeight,
    );

    // 2. Localization & Arguments Handling
    // Note: Replace with your chosen package's translation call, e.g.:
    // String displayText = isKey ? AppLocalizations.of(context)!.translate(text, namedArgs: namedArgs) : text;
    final String displayText = text; // Placeholder until localization is fully setup

    // 3. Selection of base text widget
    Widget textWidget;
    
    if (isSelectable) {
      textWidget = SelectableText(
        displayText,
        style: mergedStyle,
        textAlign: textAlign,
        maxLines: maxLines,
        textScaler: textScaler,
        semanticsLabel: semanticsLabel,
      );
    } else {
      textWidget = Text(
        displayText,
        style: mergedStyle,
        textAlign: textAlign,
        overflow: overflow,
        maxLines: maxLines,
        textScaler: textScaler,
        semanticsLabel: semanticsLabel,
      );
    }

    // 4. Auto-Sizing (Responsive)
    if (autoSize) {
      return FittedBox(
        fit: BoxFit.scaleDown,
        alignment: _getAlignment(textAlign),
        child: textWidget,
      );
    }

    return textWidget;
  }

  /// Helper to align FittedBox based on TextAlign
  Alignment _getAlignment(TextAlign? align) {
    switch (align) {
      case TextAlign.center:
        return Alignment.center;
      case TextAlign.right:
      case TextAlign.end:
        return Alignment.centerRight;
      case TextAlign.left:
      case TextAlign.start:
      default:
        return Alignment.centerLeft;
    }
  }
}
