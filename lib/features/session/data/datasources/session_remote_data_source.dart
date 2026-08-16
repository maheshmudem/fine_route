import 'package:dio/dio.dart';
import '../../../../core/error/exceptions.dart';
import '../../../../core/network/api_client.dart';
import '../../../../core/network/api_endpoints.dart';
import '../models/session_model.dart';

abstract class SessionRemoteDataSource {
  Future<List<SessionModel>> getSessions({int page = 1, int pageSize = 100});
  Future<void> revokeSession(int id);
}

class SessionRemoteDataSourceImpl implements SessionRemoteDataSource {
  final ApiClient apiClient;

  SessionRemoteDataSourceImpl({required this.apiClient});

  @override
  Future<List<SessionModel>> getSessions({int page = 1, int pageSize = 100}) async {
    try {
      final response = await apiClient.get(
        ApiEndpoints.sessions, // Using the same endpoint as Device
        queryParameters: {
          'page': page,
          'page_size': pageSize,
        },
      );

      if (response.statusCode == 200 && response.data != null) {
        final data = response.data['data'] as List;
        return data.map((json) => SessionModel.fromJson(json)).toList();
      } else {
        throw ServerException(message: 'Failed to load sessions');
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
        throw ServerException(message: 'Failed to revoke session');
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
