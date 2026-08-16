import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../config/theme/app_colors.dart';
import '../../../../core/widgets/app_loader.dart';
import '../../../../core/widgets/app_text.dart';
import '../../../../di/injection_container.dart';
import '../../../profile/presentation/bloc/profile_bloc.dart';
import '../../../profile/presentation/bloc/profile_event.dart';
import '../../../profile/presentation/bloc/profile_state.dart';
import '../bloc/dashboard_bloc.dart';
import '../bloc/dashboard_event.dart';
import '../bloc/dashboard_state.dart';
import '../widgets/action_buttons_section.dart';
import '../widgets/configured_route_lines_section.dart';
import '../widgets/daily_route_cash_section.dart';
import '../widgets/metric_grid_section.dart';
import '../widgets/recent_collections_section.dart';
import '../widgets/weekly_trend_chart_section.dart';

class DashboardPage extends StatelessWidget {
  const DashboardPage({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(create: (context) => getIt<ProfileBloc>()..add(GetProfileEvent())),
        BlocProvider(create: (context) => getIt<DashboardBloc>()..add(LoadDashboardData())),
      ],
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
      body: BlocBuilder<DashboardBloc, DashboardState>(
        builder: (context, state) {
          if (state is DashboardLoading) {
            return const Center(child: AppLoader());
          } else if (state is DashboardError) {
            return Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  AppText.bodyLarge(state.message, color: AppColors.error),
                  const SizedBox(height: 16),
                  ElevatedButton(
                    onPressed: () => context.read<DashboardBloc>().add(LoadDashboardData()),
                    child: const AppText.labelMedium('Retry', color: Colors.white),
                  ),
                ],
              ),
            );
          } else if (state is DashboardLoaded) {
            return RefreshIndicator(
              onRefresh: () async {
                context.read<DashboardBloc>().add(LoadDashboardData());
              },
              child: ListView(
                padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
                children: [
                  const ActionButtonsSection(),
                  const SizedBox(height: 24),
                  const ConfiguredRouteLinesSection(),
                  const SizedBox(height: 24),
                  DailyRouteCashSection(metrics: state.dashboardData.metrics),
                  const SizedBox(height: 12),
                  MetricGridSection(metrics: state.dashboardData.metrics),
                  const SizedBox(height: 16),
                  WeeklyTrendChartSection(weeklySummary: state.weeklySummary),
                  const SizedBox(height: 16),
                  RecentCollectionsSection(collections: state.dashboardData.recentCollections),
                ],
              ),
            );
          }
          return const SizedBox.shrink();
        },
      ),
    );
  }
}
