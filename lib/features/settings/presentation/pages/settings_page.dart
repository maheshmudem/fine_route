import 'package:flutter/material.dart';
import '../../../../config/theme/app_colors.dart';
import '../../../../core/widgets/app_text.dart';
import '../widgets/settings_action_tile.dart';
import '../widgets/settings_dropdown_tile.dart';
import '../widgets/settings_section_card.dart';
import '../widgets/settings_switch_tile.dart';

class SettingsPage extends StatefulWidget {
  const SettingsPage({super.key});

  @override
  State<SettingsPage> createState() => _SettingsPageState();
}

class _SettingsPageState extends State<SettingsPage> {
  // Mock State
  String _selectedLanguage = 'English';
  String _selectedTheme = 'System';
  bool _compactMode = false;
  bool _weeklyDigest = true;
  bool _collectionReminders = true;
  bool _overdueAlerts = true;
  bool _expenseLimitWarnings = true;
  bool _productNewsTips = false;
  bool _automaticBackup = true;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.scaffoldBackground,
      appBar: AppBar(
        title: const AppText.headlineSmall('Settings', color: AppColors.textHeading, fontWeight: FontWeight.bold),
        backgroundColor: AppColors.surfaceColor,
        elevation: 0,
        actions: [
          IconButton(
            icon: const Icon(Icons.search, color: AppColors.iconColor),
            onPressed: () {},
          ),
        ],
      ),
      body: ListView(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 24),
        children: [
          _buildSectionHeader('General'),
          SettingsSectionCard(children: [
            SettingsDropdownTile(title: 'Language', subtitle: 'Change the app language', options: const ['English', 'Spanish', 'French'], currentValue: _selectedLanguage, onChanged: (val) => setState(() => _selectedLanguage = val!)),
            const Divider(height: 1, indent: 16, color: AppColors.divider),
            SettingsDropdownTile(title: 'Theme', subtitle: 'Light, dark or system', options: const ['System', 'Light', 'Dark'], currentValue: _selectedTheme, onChanged: (val) => setState(() => _selectedTheme = val!)),
            const Divider(height: 1, indent: 16, color: AppColors.divider),
            SettingsSwitchTile(title: 'Compact mode', subtitle: 'Denser tables and lists', value: _compactMode, onChanged: (val) => setState(() => _compactMode = val)),
            const Divider(height: 1, indent: 16, color: AppColors.divider),
            SettingsSwitchTile(title: 'Weekly digest', subtitle: 'Receive a Monday morning summary', value: _weeklyDigest, onChanged: (val) => setState(() => _weeklyDigest = val)),
          ]),
          const SizedBox(height: 24),
          
          _buildSectionHeader('Notifications'),
          SettingsSectionCard(children: [
            SettingsSwitchTile(title: 'Collection reminders', value: _collectionReminders, onChanged: (val) => setState(() => _collectionReminders = val)),
            const Divider(height: 1, indent: 16, color: AppColors.divider),
            SettingsSwitchTile(title: 'Overdue alerts', value: _overdueAlerts, onChanged: (val) => setState(() => _overdueAlerts = val)),
            const Divider(height: 1, indent: 16, color: AppColors.divider),
            SettingsSwitchTile(title: 'Expense limit warnings', value: _expenseLimitWarnings, onChanged: (val) => setState(() => _expenseLimitWarnings = val)),
            const Divider(height: 1, indent: 16, color: AppColors.divider),
            SettingsSwitchTile(title: 'Product news & tips', value: _productNewsTips, onChanged: (val) => setState(() => _productNewsTips = val)),
          ]),
          const SizedBox(height: 24),

          _buildSectionHeader('Backup & Data'),
          SettingsSectionCard(children: [
            SettingsSwitchTile(title: 'Automatic backup', subtitle: 'Local backup every 24 hours', value: _automaticBackup, onChanged: (val) => setState(() => _automaticBackup = val)),
            const Divider(height: 1, indent: 16, color: AppColors.divider),
            SettingsActionTile(title: 'Export data', subtitle: 'Download all customers, collections...', icon: Icons.download, buttonText: 'Export', onPressed: () {}),
            const Divider(height: 1, indent: 16, color: AppColors.divider),
            SettingsActionTile(title: 'Delete workspace', subtitle: 'Permanently remove all data', buttonText: 'Delete', onPressed: () {}, isDestructive: true),
          ]),
        ],
      ),
    );
  }

  Widget _buildSectionHeader(String title) {
    return Padding(
      padding: const EdgeInsets.only(left: 4, bottom: 8),
      child: AppText.labelLarge(
        title.toUpperCase(),
        color: AppColors.textCaption,
        fontWeight: FontWeight.bold,
      ),
    );
  }
}
