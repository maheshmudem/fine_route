import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../config/theme/app_colors.dart';
import '../../../../core/widgets/app_text.dart';
import '../../../../di/injection_container.dart';
import '../../../profile/presentation/bloc/profile_bloc.dart';
import '../../../profile/presentation/bloc/profile_event.dart';
import '../../../profile/presentation/bloc/profile_state.dart';

class DashboardPage extends StatelessWidget {
  const DashboardPage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => getIt<ProfileBloc>()..add(GetProfileEvent()),
      child: const _DashboardView(),
    );
  }
}

class _DashboardView extends StatelessWidget {
  const _DashboardView();

  String _getGreeting() {
    final hour = DateTime.now().hour;
    if (hour < 12) {
      return 'Good Morning,';
    } else if (hour < 17) {
      return 'Good Afternoon,';
    } else {
      return 'Good Evening,';
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.scaffoldBackground,
      appBar: AppBar(
        backgroundColor: AppColors.surfaceColor,
        elevation: 0,
        titleSpacing: 0,
        leading: const Padding(
          padding: EdgeInsets.all(10.0),
          child: CircleAvatar(
            backgroundColor: AppColors.primary,
            child: Icon(Icons.person, color: Colors.white, size: 20),
          ),
        ),
        title: BlocBuilder<ProfileBloc, ProfileState>(
          builder: (context, state) {
            String name = 'Guest';
            if (state is ProfileLoaded) {
              name = state.profile.fullName.split(' ').first;
            }
            return Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                AppText.labelSmall(
                  _getGreeting(),
                  color: AppColors.textCaption,
                ),
                AppText.titleMedium(
                  name,
                  fontWeight: FontWeight.bold,
                  color: AppColors.textHeading,
                ),
              ],
            );
          },
        ),
        actions: [
          IconButton(
            icon: const Icon(Icons.notifications_none, color: AppColors.textHeading),
            onPressed: () {},
          ),
          const SizedBox(width: 8),
        ],
      ),
      body: const Center(
        child: AppText.displaySmall('Dashboard'),
      ),
    );
  }
}
