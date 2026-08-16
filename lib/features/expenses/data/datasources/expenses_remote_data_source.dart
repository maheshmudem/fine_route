import '../../../../core/network/api_client.dart';
import '../../../../core/network/api_endpoints.dart';
import '../models/expense_category_model.dart';
import '../models/expense_model.dart';
import '../models/payment_mode_model.dart';

abstract class ExpensesRemoteDataSource {
  Future<List<ExpenseModel>> getExpenses({String? dateFrom, String? dateTo});
  Future<List<ExpenseCategoryModel>> getExpenseCategories();
  Future<List<PaymentModeModel>> getPaymentModes();
  Future<ExpenseModel> addExpense(Map<String, dynamic> data);
}

class ExpensesRemoteDataSourceImpl implements ExpensesRemoteDataSource {
  final ApiClient apiClient;

  ExpensesRemoteDataSourceImpl(this.apiClient);

  @override
  Future<List<ExpenseModel>> getExpenses({String? dateFrom, String? dateTo}) async {
    String url = '${ApiEndpoints.expenses}?page_size=1000';
    if (dateFrom != null && dateTo != null) {
      url += '&date_from=$dateFrom&date_to=$dateTo';
    }

    final response = await apiClient.get(url);
    if (response.data['success'] == true) {
      final data = response.data['data'] as List;
      return data.map((e) => ExpenseModel.fromJson(e)).toList();
    } else {
      throw Exception(response.data['message'] ?? 'Failed to fetch expenses');
    }
  }

  @override
  Future<List<ExpenseCategoryModel>> getExpenseCategories() async {
    final response = await apiClient.get(ApiEndpoints.expenseCategories);
    if (response.data['success'] == true) {
      final data = response.data['data'] as List;
      return data.map((e) => ExpenseCategoryModel.fromJson(e)).toList();
    } else {
      throw Exception(response.data['message'] ?? 'Failed to fetch categories');
    }
  }

  @override
  Future<List<PaymentModeModel>> getPaymentModes() async {
    final response = await apiClient.get(ApiEndpoints.paymentModes);
    if (response.data['success'] == true) {
      final data = response.data['data'] as List;
      return data.map((e) => PaymentModeModel.fromJson(e)).toList();
    } else {
      throw Exception(response.data['message'] ?? 'Failed to fetch payment modes');
    }
  }

  @override
  Future<ExpenseModel> addExpense(Map<String, dynamic> data) async {
    final response = await apiClient.post(ApiEndpoints.expenses, data: data);
    if (response.data['success'] == true) {
      return ExpenseModel.fromJson(response.data['data']);
    } else {
      throw Exception(response.data['message'] ?? 'Failed to add expense');
    }
  }
}
