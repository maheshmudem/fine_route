import 'package:dio/dio.dart';
import '../../../../core/error/exceptions.dart';
import '../../../../core/network/api_client.dart';
import '../../../../core/network/api_endpoints.dart';
import '../models/device_session_model.dart';

abstract class DeviceRemoteDataSource {
  Future<List<DeviceSessionModel>> getSessions({int page = 1, int pageSize = 100});
  Future<void> revokeSession(int id);
}

class DeviceRemoteDataSourceImpl implements DeviceRemoteDataSource {
  final ApiClient apiClient;

  DeviceRemoteDataSourceImpl({required this.apiClient});

  @override
  Future<List<DeviceSessionModel>> getSessions({int page = 1, int pageSize = 100}) async {
    try {
      final response = await apiClient.get(
        ApiEndpoints.sessions,
        queryParameters: {
          'page': page,
          'page_size': pageSize,
        },
      );

      if (response.statusCode == 200 && response.data != null) {
        final data = response.data['data'] as List;
        return data.map((json) => DeviceSessionModel.fromJson(json)).toList();
      } else {
        throw const ServerException(message: 'Failed to load sessions');
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
  Future<void> revokeSession(int id) async {
    try {
      final response = await apiClient.delete('${ApiEndpoints.sessions}$id/');
      if (response.statusCode != 200 && response.statusCode != 204) {
        throw const ServerException(message: 'Failed to revoke session');
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
