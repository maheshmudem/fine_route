import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:go_router/go_router.dart';
import '../../core/constants/app_constants.dart';
import '../../di/injection_container.dart';
import '../../features/activity/presentation/pages/activity_page.dart';
import '../../features/analytics/presentation/pages/analytics_page.dart';
import '../../features/auth/presentation/pages/change_password_page.dart';
import '../../features/auth/presentation/pages/login_page.dart';
import '../../features/business/presentation/pages/business_page.dart';
import '../../features/calculator/presentation/bloc/calculator_bloc.dart';
import '../../features/calculator/presentation/pages/calculator_page.dart';
import '../../features/customers/presentation/pages/customers_page.dart';
import '../../features/dashboard/presentation/pages/dashboard_page.dart';
import '../../features/dashboard/presentation/pages/main_page.dart';
import '../../features/device/presentation/pages/device_page.dart';
import '../../features/expenses/presentation/pages/expenses_page.dart';
import '../../features/profile/domain/entities/profile.dart';
import '../../features/profile/presentation/bloc/profile_bloc.dart';
import '../../features/profile/presentation/pages/edit_profile_page.dart';
import '../../features/profile/presentation/pages/profile_page.dart';
import '../../features/route_lines/presentation/pages/routes_page.dart';
import '../../features/session/presentation/pages/session_page.dart';
import '../../features/settings/presentation/pages/settings_page.dart';
import '../../features/upgrade/presentation/pages/upgrade_page.dart';

final GlobalKey<NavigatorState> _rootNavigatorKey = GlobalKey<NavigatorState>(debugLabel: 'root');

GoRouter createRouter() {
  return GoRouter(
    navigatorKey: _rootNavigatorKey,
    initialLocation: '/',
    redirect: (context, state) async {
      final secureStorage = getIt<FlutterSecureStorage>();
      final token = await secureStorage.read(key: AppConstants.jwtTokenKey);
      final isLoggedIn = token != null && token.isNotEmpty;
      final isLoggingIn = state.matchedLocation == '/login';

      if (!isLoggedIn && !isLoggingIn) {
        return '/login';
      }

      if (isLoggedIn && isLoggingIn) {
        return '/';
      }

      return null;
    },
    routes: [
      GoRoute(
        path: '/login',
        name: 'login',
        builder: (context, state) => const LoginPage(),
      ),

      GoRoute(
        path: '/upgrade',
        name: 'upgrade',
        builder: (context, state) => const UpgradePage(),
      ),
      GoRoute(
        path: '/expenses',
        name: 'expenses',
        builder: (context, state) => const ExpensesPage(),
      ),
      GoRoute(
        path: '/calculator',
        name: 'calculator',
        builder: (context, state) => BlocProvider(
          create: (context) => getIt<CalculatorBloc>(),
          child: const CalculatorPage(),
        ),
      ),
      GoRoute(
        path: '/activity',
        name: 'activity',
        builder: (context, state) => const ActivityPage(),
      ),
      GoRoute(
        path: '/devices',
        name: 'devices',
        builder: (context, state) => const DevicePage(),
      ),
      GoRoute(
        path: '/sessions',
        name: 'sessions',
        builder: (context, state) => const SessionPage(),
      ),
      GoRoute(
        path: '/settings',
        name: 'settings',
        builder: (context, state) => const SettingsPage(),
      ),
      StatefulShellRoute.indexedStack(
        builder: (context, state, navigationShell) {
          return MainPage(navigationShell: navigationShell);
        },
        branches: [
          StatefulShellBranch(
            routes: [
              GoRoute(
                path: '/',
                name: 'dashboard',
                builder: (context, state) => const DashboardPage(),
              ),
            ],
          ),
          StatefulShellBranch(
            routes: [
              GoRoute(
                path: '/routes',
                name: 'routes',
                builder: (context, state) => const RoutesPage(),
              ),
            ],
          ),
          StatefulShellBranch(
            routes: [
              GoRoute(
                path: '/customers',
                name: 'customers',
                builder: (context, state) => const CustomersPage(),
              ),
            ],
          ),
          StatefulShellBranch(
            routes: [
              GoRoute(
                path: '/analytics',
                name: 'analytics',
                builder: (context, state) => const AnalyticsPage(),
              ),
            ],
          ),
          StatefulShellBranch(
            routes: [
              GoRoute(
                path: '/profile',
                name: 'profile',
                builder: (context, state) => const ProfilePage(),
                routes: [
                  GoRoute(
                    path: 'edit',
                    name: 'edit-profile',
                    builder: (context, state) {
                      final extra = state.extra as Map<String, dynamic>;
                      return BlocProvider<ProfileBloc>.value(
                        value: extra['bloc'] as ProfileBloc,
                        child: EditProfilePage(
                          profile: extra['profile'] as Profile,
                        ),
                      );
                    },
                  ),
                  GoRoute(
                    path: 'business',
                    name: 'business',
                    builder: (context, state) => const BusinessPage(),
                  ),
                  GoRoute(
                    path: 'change-password',
                    name: 'change-password',
                    builder: (context, state) => const ChangePasswordPage(),
                  ),
                ],
              ),
            ],
          ),
        ],
      ),
    ],
  );
}
