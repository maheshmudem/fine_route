import 'package:dio/dio.dart';
import '../../../../core/error/exceptions.dart';
import '../../../../core/network/api_client.dart';
import '../../../../core/network/api_endpoints.dart';
import '../models/business_model.dart';

abstract class BusinessRemoteDataSource {
  Future<BusinessModel> getBusiness();
  Future<BusinessModel> updateBusiness(Map<String, dynamic> data);
}

class BusinessRemoteDataSourceImpl implements BusinessRemoteDataSource {
  final ApiClient apiClient;

  BusinessRemoteDataSourceImpl({required this.apiClient});

  @override
  Future<BusinessModel> getBusiness() async {
    try {
      final response = await apiClient.get(ApiEndpoints.workspace);
      if (response.data != null && response.data['success'] == true) {
        return BusinessModel.fromJson(response.data['data']);
      } else {
        throw ServerException(message: response.data?['message'] ?? 'Unknown error occurred');
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
  Future<BusinessModel> updateBusiness(Map<String, dynamic> data) async {
    try {
      final response = await apiClient.patch(ApiEndpoints.workspace, data: data);
      if (response.data != null && response.data['success'] == true) {
        return BusinessModel.fromJson(response.data['data']);
      } else {
        throw ServerException(message: response.data?['message'] ?? 'Unknown error occurred');
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
