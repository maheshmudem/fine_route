import 'package:get_it/get_it.dart';
import 'auth_di.dart';
import 'calculator_di.dart';
import 'core_di.dart';
import 'expenses_di.dart';
import 'profile_di.dart';
import 'activity_di.dart';
import 'device_di.dart';
import 'session_di.dart';
import 'dashboard_di.dart';
import 'route_lines_di.dart';
import 'business_di.dart';

final GetIt getIt = GetIt.instance;

Future<void> setupDI() async {
  // Core Dependencies
  await setupCoreDI(getIt);

  // Feature Dependencies
  setupAuthDI(getIt);
  setupExpensesDI(getIt);
  initCalculator();
  setupProfileDI(getIt);
  initDashboard();
  initActivity();
  initDevice();
  initSession();
  initRouteLines();
  setupBusinessDI(getIt);
}
