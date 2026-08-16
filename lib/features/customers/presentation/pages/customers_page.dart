import 'package:flutter/material.dart';
import '../../../../config/theme/app_colors.dart';
import '../../../../core/widgets/app_text.dart';

class CustomersPage extends StatelessWidget {
  const CustomersPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const AppText.titleLarge('Customers', color: AppColors.textHeading, fontWeight: FontWeight.bold),
        backgroundColor: Colors.transparent,
        elevation: 0,
      ),
      body: const Center(
        child: AppText.bodyLarge('Customers Page Coming Soon', color: AppColors.textBody),
      ),
    );
  }
}
