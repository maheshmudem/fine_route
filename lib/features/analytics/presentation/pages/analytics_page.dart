import 'package:flutter/material.dart';
import '../../../../core/widgets/app_text.dart';

class AnalyticsPage extends StatelessWidget {
  const AnalyticsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: Center(
        child: AppText.displaySmall('Analytics Tab'),
      ),
    );
  }
}
