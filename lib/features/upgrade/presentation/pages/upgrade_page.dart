import 'package:flutter/material.dart';
import '../../../../config/theme/app_colors.dart';
import '../../../../core/widgets/app_text.dart';
import '../widgets/upgrade_plan_card.dart';
import '../widgets/upgrade_feature_row.dart';

class UpgradePage extends StatelessWidget {
  const UpgradePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.scaffoldBackground,
      appBar: AppBar(
        title: const AppText.bodyLarge('Upgrade Plan', fontWeight: FontWeight.bold),
        centerTitle: true,
        elevation: 0,
        backgroundColor: AppColors.surfaceColor,
        actions: [
          IconButton(
            icon: const Icon(Icons.refresh, color: AppColors.primary),
            onPressed: () {},
          )
        ],
      ),
      body: ListView(
        padding: const EdgeInsets.only(bottom: 24),
        children: [
          _buildBanner(),
          const Padding(
            padding: EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                AppText.headlineSmall('Select Operating Days Plan', fontWeight: FontWeight.bold),
                SizedBox(height: 16),
                UpgradePlanCard(
                  title: 'Free Tier',
                  subtitle: '1 Day / week for small finance setups',
                  price: '₹0',
                  days: '1 Day',
                  features: ['1 Collection Day per week', 'Unlimited Borrowers', 'Digital Collection Book'],
                  isActive: true,
                ),
                SizedBox(height: 16),
                UpgradePlanCard(
                  title: 'Plan 1 — 2 Days / Week',
                  subtitle: '2 Collection Days per week with unlimited customers',
                  price: '₹199',
                  days: '2 Days',
                  features: ['2 Collection Days / week', 'Unlimited Borrowers', 'Full Passbook & Ledger'],
                ),
                SizedBox(height: 16),
                UpgradePlanCard(
                  title: 'Plan 2 — 3 Days / Week',
                  subtitle: '3 Collection Days per week with unlimited customers',
                  price: '₹349',
                  days: '3 Days',
                  features: ['3 Collection Days / week', 'Unlimited Customers', 'Priority Customer Support'],
                  isRecommended: true,
                ),
                SizedBox(height: 16),
                UpgradePlanCard(
                  title: 'Plan 3 — 4 Days / Week',
                  subtitle: '4 Collection Days per week with unlimited customers',
                  price: '₹499',
                  days: '4 Days',
                  features: ['4 Collection Days / week', 'Multi-Route Day Filtering'],
                ),
                SizedBox(height: 16),
                UpgradePlanCard(
                  title: 'Full Week — 7 Days / Week',
                  subtitle: 'All 7 Collection Days enabled with unlimited customers',
                  price: '₹899',
                  days: '7 Days',
                  features: ['7 Collection Days (Full Week)', 'Dedicated Account Guidance'],
                ),
              ],
            ),
          ),
          _buildWhyUpgradeSection(),
        ],
      ),
    );
  }

  Widget _buildBanner() {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(24),
      decoration: const BoxDecoration(
        gradient: LinearGradient(
          colors: [Color(0xFF001529), Color(0xFF003A8C)],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              const Icon(Icons.workspace_premium, color: AppColors.accent, size: 16),
              const SizedBox(width: 8),
              AppText.labelSmall('GUEST WORKSPACE PLAN', color: AppColors.textWhite.withValues(alpha: 0.9), fontWeight: FontWeight.bold),
            ],
          ),
          const SizedBox(height: 12),
          const AppText.headlineMedium(
            'Upgrade Collection Operating Days',
            color: AppColors.textWhite,
            fontWeight: FontWeight.bold,
          ),
          const SizedBox(height: 8),
          RichText(
            text: const TextSpan(
              style: TextStyle(color: AppColors.divider, fontSize: 14),
              children: [
                TextSpan(text: 'Every guest workspace includes '),
                TextSpan(text: '1 Collection Day / Week', style: TextStyle(color: AppColors.accent, fontWeight: FontWeight.bold)),
                TextSpan(text: ' with '),
                TextSpan(text: 'Unlimited Customers', style: TextStyle(color: AppColors.accent, fontWeight: FontWeight.bold)),
                TextSpan(text: ' by default.'),
              ],
            ),
          ),
          const SizedBox(height: 24),
          Container(
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: Colors.white.withValues(alpha: 0.1),
              borderRadius: BorderRadius.circular(12),
              border: Border.all(color: Colors.white.withValues(alpha: 0.2)),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        AppText.labelSmall('ACTIVE BALANCE', color: AppColors.textWhite.withValues(alpha: 0.6), fontWeight: FontWeight.bold),
                        RichText(
                          text: const TextSpan(
                            children: [
                              TextSpan(text: '1 ', style: TextStyle(color: AppColors.textWhite, fontSize: 20, fontWeight: FontWeight.bold)),
                              TextSpan(text: 'Collection Day / Wk', style: TextStyle(color: AppColors.divider, fontSize: 14)),
                            ],
                          ),
                        ),
                      ],
                    ),
                    Container(
                      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                      decoration: BoxDecoration(
                        color: Colors.white.withValues(alpha: 0.2),
                        borderRadius: BorderRadius.circular(4),
                      ),
                      child: const AppText.labelSmall('FREE PLAN', color: AppColors.textWhite, fontWeight: FontWeight.bold),
                    ),
                  ],
                ),
                const SizedBox(height: 12),
                const Row(
                  children: [
                    Icon(Icons.groups, color: AppColors.divider, size: 16),
                    SizedBox(width: 8),
                    AppText.bodySmall('Borrower Capacity: ', color: AppColors.divider),
                    AppText.bodySmall('Unlimited', color: AppColors.textWhite, fontWeight: FontWeight.w500),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildWhyUpgradeSection() {
    return Container(
      color: AppColors.scaffoldBackground,
      padding: const EdgeInsets.all(16),
      child: const Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          AppText.labelLarge('WHY UPGRADE?', color: AppColors.textCaption, fontWeight: FontWeight.bold),
          SizedBox(height: 16),
          UpgradeFeatureRow(icon: Icons.calendar_today, color: AppColors.primary, title: 'More Collection Days', description: 'Record daily or multi-day collections easily without hitting weekly day limits.'),
          SizedBox(height: 12),
          UpgradeFeatureRow(icon: Icons.group_add, color: AppColors.success, title: 'Unlimited Borrowers', description: 'Add as many customer borrowers as you need without extra per-borrower charges.'),
          SizedBox(height: 12),
          UpgradeFeatureRow(icon: Icons.bolt, color: AppColors.accent, title: 'Instant Activation', description: 'Selected plan updates your workspace collection day allowance immediately.'),
        ],
      ),
    );
  }
}
