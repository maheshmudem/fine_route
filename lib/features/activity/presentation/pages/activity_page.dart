import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:intl/intl.dart';
import '../../../../config/theme/app_colors.dart';
import '../../../../core/widgets/app_loader.dart';
import '../../../../core/widgets/app_text.dart';
import '../../../../di/injection_container.dart';
import '../../domain/entities/activity_log.dart';
import '../bloc/activity_bloc.dart';
import '../bloc/activity_event.dart';
import '../bloc/activity_state.dart';

class ActivityPage extends StatelessWidget {
  const ActivityPage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => getIt<ActivityBloc>()..add(FetchActivitiesEvent()),
      child: const _ActivityView(),
    );
  }
}

class _ActivityView extends StatelessWidget {
  const _ActivityView();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.scaffoldBackground,
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: AppColors.iconColor),
          onPressed: () => context.pop(),
        ),
        title: const AppText.headlineSmall(
          'Audit Logs',
          color: AppColors.textHeading,
        ),
        actions: [
          IconButton(
            icon: const Icon(Icons.more_vert, color: AppColors.iconColor),
            onPressed: () {},
          )
        ],
        backgroundColor: AppColors.surfaceColor,
        elevation: 0,
      ),
      body: Column(
        children: [
          _buildHeaderInfo(),
          _buildSearchAndFilters(),
          Expanded(
            child: BlocBuilder<ActivityBloc, ActivityState>(
              builder: (context, state) {
                if (state is ActivityLoading) {
                  return const Center(child: AppLoader());
                } else if (state is ActivityError) {
                  return Center(
                    child: AppText.bodyMedium(
                      state.message,
                      color: AppColors.error,
                    ),
                  );
                } else if (state is ActivityLoaded) {
                  final activities = state.activities;
                  if (activities.isEmpty) {
                    return const Center(
                      child: AppText.bodyMedium(
                        'No activities found',
                        color: AppColors.textBody,
                      ),
                    );
                  }
                  return ListView.separated(
                    padding: const EdgeInsets.all(16),
                    itemCount: activities.length,
                    separatorBuilder: (context, index) => const SizedBox(height: 12),
                    itemBuilder: (context, index) {
                      return _buildActivityCard(activities[index]);
                    },
                  );
                }
                return const SizedBox.shrink();
              },
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildHeaderInfo() {
    return const Padding(
      padding: EdgeInsets.fromLTRB(16, 12, 16, 12),
      child: AppText.bodyMedium(
        'Complete timeline of logins, updates, customer creation, collections, and administrative actions.',
        color: AppColors.textBody,
      ),
    );
  }

  Widget _buildSearchAndFilters() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: Container(
        padding: const EdgeInsets.all(12),
        decoration: BoxDecoration(
          color: AppColors.surfaceColor,
          borderRadius: BorderRadius.circular(8),
          border: Border.all(color: AppColors.border),
        ),
        child: Column(
          children: [
            Container(
              decoration: BoxDecoration(
                color: AppColors.scaffoldBackground,
                borderRadius: BorderRadius.circular(8),
                border: Border.all(color: AppColors.border),
              ),
              child: const TextField(
                decoration: InputDecoration(
                  hintText: 'Search description...',
                  hintStyle: TextStyle(color: AppColors.textBody, fontSize: 14),
                  prefixIcon: Icon(Icons.search, color: AppColors.textBody, size: 20),
                  border: InputBorder.none,
                  contentPadding: EdgeInsets.symmetric(vertical: 12),
                ),
              ),
            ),
            const SizedBox(height: 8),
            SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: Row(
                children: [
                  _buildFilterChip('All Actions', Icons.expand_more),
                  const SizedBox(width: 8),
                  _buildFilterChip('All Days', Icons.expand_more),
                  const SizedBox(width: 8),
                  _buildFilterChip('dd-mm-yyyy', Icons.calendar_today, iconAfter: true),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildFilterChip(String label, IconData icon, {bool iconAfter = false}) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
      decoration: BoxDecoration(
        color: AppColors.scaffoldBackground,
        border: Border.all(color: AppColors.border),
        borderRadius: BorderRadius.circular(6),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          if (!iconAfter) ...[
            Icon(icon, size: 14, color: AppColors.textBody),
            const SizedBox(width: 4),
          ],
          AppText.bodySmall(label, color: AppColors.textBody, fontWeight: FontWeight.w500),
          if (iconAfter) ...[
            const SizedBox(width: 4),
            Icon(icon, size: 14, color: AppColors.textBody),
          ],
        ],
      ),
    );
  }

  Widget _buildActivityCard(ActivityLog log) {
    final isLogin = log.action.toLowerCase() == 'login';
    final badgeColor = isLogin ? Colors.green[700]! : Colors.blue[700]!;
    final badgeBgColor = isLogin ? Colors.green[50]! : Colors.blue[50]!;
    final badgeBorderColor = isLogin ? Colors.green[200]! : Colors.blue[200]!;

    final formattedDate = DateFormat('EEE, d MMM, yyyy, hh:mm a').format(log.createdAt);
    
    // truncate user agent for subtitle
    final agent = log.userAgent != null && log.userAgent!.isNotEmpty 
        ? log.userAgent! 
        : 'Web Browser';
    
    final displayAgent = agent.length > 40 ? '${agent.substring(0, 40)}...' : agent;
    final ip = log.ipAddress ?? 'Localhost';

    return Container(
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: AppColors.surfaceColor,
        borderRadius: BorderRadius.circular(8),
        border: Border.all(color: AppColors.border),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
                decoration: BoxDecoration(
                  color: badgeBgColor,
                  border: Border.all(color: badgeBorderColor),
                  borderRadius: BorderRadius.circular(4),
                ),
                child: Text(
                  log.action.toUpperCase(),
                  style: TextStyle(
                    fontSize: 10,
                    fontWeight: FontWeight.bold,
                    color: badgeColor,
                    letterSpacing: 0.5,
                  ),
                ),
              ),
              AppText.bodySmall(
                formattedDate,
                color: AppColors.textBody.withValues(alpha: 0.7),
              ),
            ],
          ),
          const SizedBox(height: 8),
          AppText.bodyMedium(
            log.description,
            fontWeight: FontWeight.w600,
            color: AppColors.textHeading,
            maxLines: 3,
            overflow: TextOverflow.ellipsis,
          ),
          const SizedBox(height: 4),
          AppText.bodySmall(
            'IP: $ip · $displayAgent',
            color: AppColors.textBody,
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
          ),
        ],
      ),
    );
  }
}
