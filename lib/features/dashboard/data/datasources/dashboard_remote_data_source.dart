import 'package:dio/dio.dart';
import '../../../../core/error/exceptions.dart';
import '../../../../core/network/api_client.dart';
import '../../../../core/network/api_endpoints.dart';
import '../models/dashboard_data_model.dart';
import '../models/weekly_summary_model.dart';

abstract class DashboardRemoteDataSource {
  Future<DashboardDataModel> getDashboardData();
  Future<List<WeeklySummaryModel>> getWeeklySummary();
}

class DashboardRemoteDataSourceImpl implements DashboardRemoteDataSource {
  final ApiClient apiClient;

  DashboardRemoteDataSourceImpl(this.apiClient);

  @override
  Future<DashboardDataModel> getDashboardData() async {
    try {
      final response = await apiClient.get(ApiEndpoints.dashboard);
      if (response.data != null && response.data['success'] == true) {
        return DashboardDataModel.fromJson(response.data['data']);
      } else {
        throw ServerException(message: response.data?['message'] ?? 'Failed to fetch dashboard data');
      }
    } on DioException catch (e) {
      if (e.error is ServerException) {
        throw e.error as ServerException;
      }
      throw ServerException(message: e.message ?? 'Network error occurred');
    } catch (e) {
      if (e is ServerException) {
        rethrow;
      }
      throw ServerException(message: e.toString());
    }
  }

  @override
  Future<List<WeeklySummaryModel>> getWeeklySummary() async {
    try {
      final response = await apiClient.get(ApiEndpoints.dashboardWeeklySummary);
      if (response.data != null && response.data['success'] == true) {
        final data = response.data['data'] as List;
        return data.map((json) => WeeklySummaryModel.fromJson(json)).toList();
      } else {
        throw ServerException(message: response.data?['message'] ?? 'Failed to fetch weekly summary');
      }
    } on DioException catch (e) {
      if (e.error is ServerException) {
        throw e.error as ServerException;
      }
      throw ServerException(message: e.message ?? 'Network error occurred');
    } catch (e) {
      if (e is ServerException) {
        rethrow;
      }
      throw ServerException(message: e.toString());
    }
  }
}
