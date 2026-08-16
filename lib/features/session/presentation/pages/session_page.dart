import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:intl/intl.dart';
import '../../../../config/theme/app_colors.dart';
import '../../../../core/widgets/app_text.dart';
import '../../../../core/widgets/app_loader.dart';
import '../../../../di/injection_container.dart';
import '../../domain/entities/session_entity.dart';
import '../bloc/session_bloc.dart';
import '../bloc/session_event.dart';
import '../bloc/session_state.dart';

class SessionPage extends StatelessWidget {
  const SessionPage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => getIt<SessionBloc>()..add(LoadSessionsEvent()),
      child: const _SessionView(),
    );
  }
}

class _SessionView extends StatelessWidget {
  const _SessionView();

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
          'Active Login Sessions',
          color: AppColors.textHeading,
          fontWeight: FontWeight.bold,
        ),
        backgroundColor: AppColors.surfaceColor,
        elevation: 0,
        centerTitle: false,
      ),
      body: BlocListener<SessionBloc, SessionState>(
        listener: (context, state) {
          if (state is SessionError) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(content: Text(state.message), backgroundColor: AppColors.error),
            );
          } else if (state is SessionActionSuccess) {
            ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(content: Text('Session signed out successfully'), backgroundColor: Colors.green),
            );
          }
        },
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              color: AppColors.surfaceColor,
              padding: const EdgeInsets.fromLTRB(16, 8, 16, 24),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  AppText.bodyMedium(
                    'Manage active signed-in browsers and mobile sessions across all your hardware.',
                    color: AppColors.textBody.withValues(alpha: 0.8),
                  ),
                  const SizedBox(height: 24),
                  _buildSearchBar(),
                  const SizedBox(height: 24),
                  _buildSignOutAllButton(context),
                ],
              ),
            ),
            Expanded(
              child: BlocBuilder<SessionBloc, SessionState>(
                buildWhen: (previous, current) => current is! SessionActionLoading && current is! SessionActionSuccess,
                builder: (context, state) {
                  if (state is SessionLoading) {
                    return const Center(child: AppLoader());
                  } else if (state is SessionError && state.message.contains('Failed')) {
                    return Center(child: AppText.bodyMedium(state.message, color: AppColors.error));
                  } else if (state is SessionLoaded) {
                    final sessions = state.sessions;
                    if (sessions.isEmpty) {
                      return const Center(child: AppText.bodyMedium('No active sessions found', color: AppColors.textBody));
                    }
                    return ListView.separated(
                      padding: const EdgeInsets.all(16),
                      itemCount: sessions.length,
                      separatorBuilder: (context, index) => const SizedBox(height: 16),
                      itemBuilder: (context, index) {
                        return _buildSessionCard(context, sessions[index]);
                      },
                    );
                  }
                  return const SizedBox.shrink();
                },
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildSearchBar() {
    return Container(
      decoration: BoxDecoration(
        color: AppColors.scaffoldBackground,
        borderRadius: BorderRadius.circular(8),
        border: Border.all(color: AppColors.border),
      ),
      child: const TextField(
        decoration: InputDecoration(
          hintText: 'Search device name, browser, or IP...',
          hintStyle: TextStyle(color: AppColors.textBody, fontSize: 14),
          prefixIcon: Icon(Icons.search, color: AppColors.textBody),
          border: InputBorder.none,
          contentPadding: EdgeInsets.symmetric(vertical: 14),
        ),
      ),
    );
  }

  Widget _buildSignOutAllButton(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      child: OutlinedButton(
        onPressed: () {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(content: Text('Sign out of all sessions not fully implemented yet.')),
          );
        },
        style: OutlinedButton.styleFrom(
          backgroundColor: Colors.red[50],
          side: BorderSide(color: Colors.red[200]!),
          padding: const EdgeInsets.symmetric(vertical: 12),
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
        ),
        child: Text(
          'Sign out of all sessions',
          style: TextStyle(
            fontSize: 14,
            fontWeight: FontWeight.w500,
            color: Colors.red[600],
          ),
        ),
      ),
    );
  }

  Widget _buildSessionCard(BuildContext context, SessionEntity session) {
    final parsedDevice = _parseUserAgent(session.userAgent);
    final dateStr = DateFormat('M/d/yyyy').format(session.lastActivityAt);
    final ipStr = session.ipAddress ?? 'Unknown IP';
    
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: AppColors.surfaceColor,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: AppColors.border),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.02),
            blurRadius: 4,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Stack(
        children: [
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                width: 40,
                height: 40,
                decoration: BoxDecoration(
                  color: AppColors.scaffoldBackground,
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Icon(parsedDevice.icon, color: AppColors.textBody, size: 20),
              ),
              const SizedBox(width: 16),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        AppText.bodyLarge(
                          parsedDevice.name,
                          fontWeight: FontWeight.w600,
                          color: AppColors.textHeading,
                        ),
                        if (session.isActive) ...[
                          const SizedBox(width: 8),
                          Container(
                            padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 2),
                            decoration: BoxDecoration(
                              color: Colors.green[50],
                              borderRadius: BorderRadius.circular(12),
                            ),
                            child: Text(
                              'Current Session',
                              style: TextStyle(
                                fontSize: 10,
                                fontWeight: FontWeight.w500,
                                color: Colors.green[800],
                              ),
                            ),
                          ),
                        ]
                      ],
                    ),
                    const SizedBox(height: 4),
                    AppText.bodySmall(
                      '$ipStr · ${parsedDevice.description}',
                      color: AppColors.textBody,
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                    ),
                    const SizedBox(height: 8),
                    RichText(
                      text: TextSpan(
                        text: 'Last active: ',
                        style: const TextStyle(fontSize: 12, color: AppColors.textBody),
                        children: [
                          TextSpan(
                            text: dateStr,
                            style: const TextStyle(fontWeight: FontWeight.w500, color: AppColors.textHeading),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
          Positioned(
            top: -12,
            right: -12,
            child: IconButton(
              icon: const Icon(Icons.delete_outline, color: AppColors.textBody, size: 20),
              onPressed: () {
                context.read<SessionBloc>().add(RevokeSessionEvent(session.id));
              },
            ),
          ),
        ],
      ),
    );
  }

  _ParsedDevice _parseUserAgent(String userAgent) {
    final ua = userAgent.toLowerCase();
    
    String name = 'Web Session';
    IconData icon = Icons.laptop_mac;
    String description = userAgent;

    if (ua.contains('iphone') || ua.contains('ipad') || ua.contains('ios')) {
      name = 'Mobile App';
      icon = Icons.smartphone;
    } else if (ua.contains('android')) {
      name = 'Mobile App';
      icon = Icons.smartphone;
    } else if (ua.contains('windows')) {
      name = 'Web Session';
      icon = Icons.laptop_windows;
    } else if (ua.contains('mac')) {
      name = 'Web Session';
      icon = Icons.laptop_mac;
    } else if (ua.contains('linux')) {
      name = 'Web Session';
      icon = Icons.laptop;
    }

    if (description.length > 40) {
      description = '${description.substring(0, 40)}...';
    }

    return _ParsedDevice(name, icon, description);
  }
}

class _ParsedDevice {
  final String name;
  final IconData icon;
  final String description;

  _ParsedDevice(this.name, this.icon, this.description);
}
