import 'package:flutter/material.dart';
import '../../../../../config/theme/app_colors.dart';
import '../../../../../core/widgets/app_text.dart';

class UpgradePlanCard extends StatelessWidget {
  final String title;
  final String subtitle;
  final String price;
  final String days;
  final List<String> features;
  final bool isActive;
  final bool isRecommended;

  const UpgradePlanCard({
    super.key,
    required this.title,
    required this.subtitle,
    required this.price,
    required this.days,
    required this.features,
    this.isActive = false,
    this.isRecommended = false,
  });

  @override
  Widget build(BuildContext context) {
    return Stack(
      clipBehavior: Clip.none,
      children: [
        Container(
          padding: const EdgeInsets.all(16),
          decoration: BoxDecoration(
            color: AppColors.cardBackground,
            borderRadius: BorderRadius.circular(16),
            border: Border.all(color: isRecommended ? AppColors.accent : AppColors.border, width: isRecommended ? 2 : 1),
            boxShadow: const [
              BoxShadow(
                color: AppColors.shadowColor,
                blurRadius: 4,
                offset: Offset(0, 2),
              ),
            ],
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              if (isActive)
                Align(
                  alignment: Alignment.topRight,
                  child: Container(
                    padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 2),
                    decoration: const BoxDecoration(
                      color: AppColors.success,
                      borderRadius: BorderRadius.only(bottomLeft: Radius.circular(8)),
                    ),
                    child: const AppText.labelSmall('DEFAULT', color: AppColors.textWhite, fontWeight: FontWeight.bold),
                  ),
                ),
              AppText.bodyLarge(title, fontWeight: FontWeight.bold, color: AppColors.textHeading),
              AppText.bodySmall(subtitle, color: AppColors.textCaption),
              const SizedBox(height: 12),
              Row(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  AppText.headlineSmall(price, fontWeight: FontWeight.bold, color: AppColors.textHeading),
                  const Padding(
                    padding: EdgeInsets.only(bottom: 4, left: 4),
                    child: AppText.bodySmall('/ month', color: AppColors.textCaption),
                  ),
                ],
              ),
              const SizedBox(height: 12),
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
                decoration: BoxDecoration(
                  color: isActive ? AppColors.scaffoldBackground : AppColors.primary.withValues(alpha: 0.1),
                  borderRadius: BorderRadius.circular(8),
                  border: Border.all(color: isActive ? AppColors.border : Colors.transparent),
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Row(
                      children: [
                        Icon(Icons.calendar_month, size: 16, color: isActive ? AppColors.iconColor : AppColors.primary),
                        const SizedBox(width: 8),
                        AppText.labelSmall('Days / Week:', fontWeight: FontWeight.w600, color: isActive ? AppColors.textHeading : AppColors.primary),
                      ],
                    ),
                    AppText.labelSmall(days, fontWeight: FontWeight.bold, color: isActive ? AppColors.textHeading : AppColors.primary),
                  ],
                ),
              ),
              const SizedBox(height: 16),
              ...features.map((feature) => Padding(
                    padding: const EdgeInsets.only(bottom: 8),
                    child: Row(
                      children: [
                        const Icon(Icons.check_circle, color: AppColors.success, size: 16),
                        const SizedBox(width: 8),
                        AppText.bodySmall(feature, color: AppColors.textBody),
                      ],
                    ),
                  )),
              const SizedBox(height: 8),
              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: isActive ? null : () {},
                  style: ElevatedButton.styleFrom(
                    backgroundColor: isActive ? AppColors.divider : AppColors.primary,
                    foregroundColor: isActive ? AppColors.textCaption : AppColors.textWhite,
                    padding: const EdgeInsets.symmetric(vertical: 12),
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
                    elevation: 0,
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(isActive ? 'Active Plan' : 'Select Plan', style: const TextStyle(fontWeight: FontWeight.bold)),
                      if (!isActive) ...[
                        const SizedBox(width: 8),
                        const Icon(Icons.arrow_forward, size: 16),
                      ],
                    ],
                  ),
                ),
              )
            ],
          ),
        ),
        if (isRecommended)
          Positioned(
            top: -12,
            left: 0,
            right: 0,
            child: Center(
              child: Container(
                padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 4),
                decoration: BoxDecoration(
                  color: AppColors.accent,
                  borderRadius: BorderRadius.circular(16),
                  boxShadow: const [BoxShadow(color: Colors.black12, blurRadius: 4, offset: Offset(0, 2))],
                ),
                child: const AppText.labelSmall('RECOMMENDED', color: AppColors.textWhite, fontWeight: FontWeight.w900),
              ),
            ),
          ),
      ],
    );
  }
}
