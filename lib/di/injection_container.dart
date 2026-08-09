import 'package:get_it/get_it.dart';
import 'auth_di.dart';
import 'calculator_di.dart';
import 'core_di.dart';
import 'expenses_di.dart';
import 'profile_di.dart';

final GetIt getIt = GetIt.instance;

Future<void> setupDI() async {
  // Core Dependencies
  await setupCoreDI(getIt);

  // Feature Dependencies
  setupAuthDI(getIt);
  setupExpensesDI(getIt);
  initCalculator();
  setupProfileDI(getIt);
}
