class ApiEndpoints {
  ApiEndpoints._();

  // Auth
  static const String login = '/auth/login/';
  static const String me = '/auth/me/';
  static const String activity = '/auth/me/activity/';
  static const String sessions = '/auth/sessions/';
  
  // Expenses
  static const String expenses = '/app/expenses/';
  static const String expenseCategories = '/masters/expense-categories/';
  static const String paymentModes = '/masters/payment-modes/';

  // Calculator
  static const String calculator = '/app/calculator/';

  // Dashboard
  static const String dashboard = '/app/dashboard/';
  static const String dashboardWeeklySummary = '/app/dashboard/weekly-summary/';
  // Route Lines
  static const String lines = '/app/lines/';
  static const String linesAvailablePortions = '/app/lines/available-portions/';
}
