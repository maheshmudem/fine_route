import 'package:dio/dio.dart';
import '../../../../core/error/exceptions.dart';
import '../../../../core/network/api_client.dart';
import '../../../../core/network/api_endpoints.dart';
import '../models/activity_log_model.dart';

abstract class ActivityRemoteDataSource {
  Future<List<ActivityLogModel>> getActivities({int page = 1, int pageSize = 100});
}

class ActivityRemoteDataSourceImpl implements ActivityRemoteDataSource {
  final ApiClient apiClient;

  ActivityRemoteDataSourceImpl({required this.apiClient});

  @override
  Future<List<ActivityLogModel>> getActivities({int page = 1, int pageSize = 100}) async {
    try {
      final response = await apiClient.get(
        ApiEndpoints.activity,
        queryParameters: {
          'page': page,
          'page_size': pageSize,
        },
      );

      if (response.statusCode == 200 && response.data != null) {
        final data = response.data['data'] as List;
        return data.map((json) => ActivityLogModel.fromJson(json)).toList();
      } else {
        throw const ServerException(message: 'Failed to load activities');
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
