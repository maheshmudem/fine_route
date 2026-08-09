import '../../../../core/network/api_client.dart';
import '../../../../core/network/api_endpoints.dart';
import '../models/loan_calculation_model.dart';

abstract class CalculatorRemoteDataSource {
  Future<LoanCalculationModel> calculateLoan(Map<String, dynamic> data);
}

class CalculatorRemoteDataSourceImpl implements CalculatorRemoteDataSource {
  final ApiClient apiClient;

  CalculatorRemoteDataSourceImpl(this.apiClient);

  @override
  Future<LoanCalculationModel> calculateLoan(Map<String, dynamic> data) async {
    final response = await apiClient.post(ApiEndpoints.calculator, data: data);
    if (response.data['success'] == true) {
      return LoanCalculationModel.fromJson(response.data['data']);
    } else {
      throw Exception(response.data['message'] ?? 'Failed to calculate loan');
    }
  }
}
