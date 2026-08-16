import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import '../../../../config/theme/app_colors.dart';
import '../../../../core/widgets/app_loader.dart';
import '../../../../core/widgets/app_text.dart';
import '../../../../di/injection_container.dart';
import '../../../../features/auth/presentation/bloc/auth_bloc.dart';
import '../../../../features/auth/presentation/bloc/auth_event.dart';
import '../../../../features/auth/presentation/bloc/auth_state.dart';
import '../../domain/entities/profile.dart';
import '../bloc/profile_bloc.dart';
import '../bloc/profile_event.dart';
import '../bloc/profile_state.dart';

class ProfilePage extends StatelessWidget {
  const ProfilePage({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(create: (context) => getIt<ProfileBloc>()..add(GetProfileEvent())),
        BlocProvider(create: (context) => getIt<AuthBloc>()),
      ],
      child: const _ProfileView(),
    );
  }
}

class _ProfileView extends StatelessWidget {
  const _ProfileView();

  void _onLogout(BuildContext context) {
    context.read<AuthBloc>().add(LogoutRequested());
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<AuthBloc, AuthState>(
      listener: (context, state) {
        if (state is AuthUnauthenticated) {
          context.go('/login');
        }
      },
      child: Scaffold(
        backgroundColor: AppColors.scaffoldBackground,
        appBar: AppBar(
          title: const AppText.headlineSmall('Profile', color: AppColors.textHeading),
          centerTitle: true,
          elevation: 0,
          backgroundColor: AppColors.surfaceColor,
        ),
        body: BlocBuilder<ProfileBloc, ProfileState>(
          builder: (context, state) {
            if (state is ProfileLoading) {
              return const Center(child: AppLoader()); 
            } else if (state is ProfileError) {
              return Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    AppText.bodyMedium(state.message, color: AppColors.error),
                    const SizedBox(height: 16),
                    ElevatedButton(
                      onPressed: () => _onLogout(context),
                      style: ElevatedButton.styleFrom(
                        backgroundColor: AppColors.primary,
                        foregroundColor: AppColors.textWhite,
                      ),
                      child: const Text('Log In'),
                    ),
                  ],
                ),
              );
            } else if (state is ProfileLoaded) {
              final profile = state.profile;
              return SingleChildScrollView(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  children: [
                    _buildProfileHeader(context, profile),
                    const SizedBox(height: 32),
                    _buildOptionsList(context),
                  ],
                ),
              );
            }
            return const SizedBox.shrink();
          },
        ),
      ),
    );
  }

  Widget _buildProfileHeader(BuildContext context, Profile profile) {
    return Column(
      children: [
        Stack(
          children: [
            const CircleAvatar(
              radius: 50,
              backgroundColor: AppColors.divider,
              child: Icon(Icons.person, size: 50, color: AppColors.iconColor),
            ),
            Positioned(
              bottom: 0,
              right: 0,
              child: Container(
                decoration: BoxDecoration(
                  color: AppColors.primary,
                  shape: BoxShape.circle,
                  border: Border.all(color: AppColors.surfaceColor, width: 2),
                ),
                child: IconButton(
                  icon: const Icon(Icons.edit, size: 16, color: AppColors.textWhite),
                  onPressed: () {
                    context.push('/profile/edit', extra: {
                      'profile': profile,
                      'bloc': context.read<ProfileBloc>(),
                    });
                  },
                  constraints: const BoxConstraints(minWidth: 32, minHeight: 32),
                  padding: EdgeInsets.zero,
                ),
              ),
            ),
          ],
        ),
        const SizedBox(height: 16),
        AppText.headlineSmall(
          profile.fullName,
          fontWeight: FontWeight.bold,
          color: AppColors.textHeading,
        ),
        const SizedBox(height: 4),
        AppText.bodyMedium(
          profile.email,
          color: AppColors.textBody,
        ),
        const SizedBox(height: 4),
        AppText.bodyMedium(
          profile.mobileNumber,
          color: AppColors.textBody,
        ),
        const SizedBox(height: 12),
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
          decoration: BoxDecoration(
            color: AppColors.primary.withValues(alpha: 0.1),
            borderRadius: BorderRadius.circular(20),
          ),
          child: AppText.bodySmall(
            profile.accountType.toUpperCase(),
            fontWeight: FontWeight.w600,
            color: AppColors.primary,
          ),
        ),
      ],
    );
  }

  Widget _buildOptionsList(BuildContext context) {
    return Card(
      elevation: 0,
      color: AppColors.cardBackground,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(16),
        side: const BorderSide(color: AppColors.border),
      ),
      child: Column(
        children: [
          _buildListTile(context, icon: Icons.business, title: 'Business', onTap: () => context.push('/profile/business')),
          const Divider(height: 1, indent: 56, color: AppColors.divider),
          _buildListTile(context, icon: Icons.lock_outline, title: 'Security', onTap: () => context.push('/profile/change-password')),
          const Divider(height: 1, indent: 56, color: AppColors.divider),
          _buildListTile(context, icon: Icons.settings, title: 'Settings', onTap: () => context.push('/settings')),
          const Divider(height: 1, indent: 56, color: AppColors.divider),
          _buildListTile(context, icon: Icons.upgrade, title: 'Upgrade', onTap: () => context.push('/upgrade')),
          const Divider(height: 1, indent: 56, color: AppColors.divider),
          _buildListTile(context, icon: Icons.history, title: 'Activity', onTap: () => context.push('/activity')),
          const Divider(height: 1, indent: 56, color: AppColors.divider),
          _buildListTile(context, icon: Icons.devices, title: 'Devices & Hardware', onTap: () => context.push('/devices')),
          const Divider(height: 1, indent: 56, color: AppColors.divider),
          _buildListTile(context, icon: Icons.supervised_user_circle, title: 'Active Login Sessions', onTap: () => context.push('/sessions')),
          const Divider(height: 1, indent: 56, color: AppColors.divider),
          _buildListTile(context, icon: Icons.receipt_long, title: 'Expenses', onTap: () => context.push('/expenses')),
          const Divider(height: 1, indent: 56, color: AppColors.divider),
          _buildListTile(context, icon: Icons.notifications, title: 'Notifications', onTap: () {}),
          const Divider(height: 1, indent: 56, color: AppColors.divider),
          _buildListTile(context, icon: Icons.calculate, title: 'Loan Calculator', onTap: () => context.push('/calculator')),
          const Divider(height: 1, indent: 56, color: AppColors.divider),
          _buildListTile(
            context,
            icon: Icons.logout,
            title: 'Log out',
            isDestructive: true,
            onTap: () => _onLogout(context),
          ),
        ],
      ),
    );
  }

  Widget _buildListTile(
    BuildContext context, {
    required IconData icon,
    required String title,
    required VoidCallback onTap,
    bool isDestructive = false,
  }) {
    final color = isDestructive ? AppColors.error : AppColors.iconColor;
    return ListTile(
      leading: Container(
        padding: const EdgeInsets.all(8),
        decoration: BoxDecoration(
          color: isDestructive ? AppColors.error.withValues(alpha: 0.1) : AppColors.divider,
          borderRadius: BorderRadius.circular(8),
        ),
        child: Icon(icon, color: color),
      ),
      title: AppText.bodyMedium(
        title,
        color: color,
        fontWeight: FontWeight.w500,
      ),
      trailing: Icon(Icons.chevron_right, size: 20, color: AppColors.iconColor.withValues(alpha: 0.5)),
      onTap: onTap,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
    );
  }
}
