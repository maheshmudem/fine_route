import 'package:dio/dio.dart';
import '../../../../core/error/exceptions.dart';
import '../../../../core/network/api_client.dart';
import '../../../../core/network/api_endpoints.dart';
import '../models/route_line_model.dart';

abstract class RouteLinesRemoteDataSource {
  Future<Map<String, List<String>>> getAvailablePortions({String? excludeLineId});
  Future<List<RouteLineModel>> getRouteLines();
  Future<RouteLineModel> createRouteLine(String name, String area, List<Map<String, dynamic>> schedules);
  Future<RouteLineModel> updateRouteLine(String publicId, String name, String area, List<Map<String, dynamic>> schedules);
  Future<void> deleteRouteLine(String publicId);
}

class RouteLinesRemoteDataSourceImpl implements RouteLinesRemoteDataSource {
  final ApiClient apiClient;

  RouteLinesRemoteDataSourceImpl({required this.apiClient});

  @override
  Future<Map<String, List<String>>> getAvailablePortions({String? excludeLineId}) async {
    try {
      final url = excludeLineId != null 
          ? '${ApiEndpoints.linesAvailablePortions}?exclude_line_id=$excludeLineId'
          : ApiEndpoints.linesAvailablePortions;
      final response = await apiClient.get(url);
      if (response.statusCode == 200 && response.data != null && response.data['data'] != null) {
        final Map<String, dynamic> data = response.data['data'];
        final Map<String, List<String>> result = {};
        data.forEach((key, value) {
          result[key] = List<String>.from(value);
        });
        return result;
      } else {
        throw const ServerException(message: 'Failed to load available portions');
      }
    } on DioException catch (e) {
      if (e.error is ServerException) throw e.error as ServerException;
      throw ServerException(message: e.message ?? 'Network error occurred');
    } catch (e) {
      if (e is ServerException) rethrow;
      throw ServerException(message: e.toString());
    }
  }

  @override
  Future<List<RouteLineModel>> getRouteLines() async {
    try {
      final response = await apiClient.get(ApiEndpoints.lines);
      if (response.statusCode == 200 && response.data != null && response.data['data'] != null) {
        final data = response.data['data'] as List;
        return data.map((json) => RouteLineModel.fromJson(json)).toList();
      } else {
        throw const ServerException(message: 'Failed to load route lines');
      }
    } on DioException catch (e) {
      if (e.error is ServerException) throw e.error as ServerException;
      throw ServerException(message: e.message ?? 'Network error occurred');
    } catch (e) {
      if (e is ServerException) rethrow;
      throw ServerException(message: e.toString());
    }
  }

  @override
  Future<RouteLineModel> createRouteLine(String name, String area, List<Map<String, dynamic>> schedules) async {
    try {
      final response = await apiClient.post(
        ApiEndpoints.lines,
        data: {
          'name': name,
          'area': area,
          'schedules': schedules,
        },
      );
      if ((response.statusCode == 200 || response.statusCode == 201) && response.data != null && response.data['data'] != null) {
        return RouteLineModel.fromJson(response.data['data']);
      } else {
        throw const ServerException(message: 'Failed to create route line');
      }
    } on DioException catch (e) {
      if (e.error is ServerException) throw e.error as ServerException;
      throw ServerException(message: e.message ?? 'Network error occurred');
    } catch (e) {
      if (e is ServerException) rethrow;
      throw ServerException(message: e.toString());
    }
  }

  @override
  Future<RouteLineModel> updateRouteLine(String publicId, String name, String area, List<Map<String, dynamic>> schedules) async {
    try {
      final response = await apiClient.patch(
        '${ApiEndpoints.lines}$publicId/',
        data: {
          'name': name,
          'area': area,
          'schedules': schedules,
        },
      );
      if ((response.statusCode == 200 || response.statusCode == 201) && response.data != null && response.data['data'] != null) {
        return RouteLineModel.fromJson(response.data['data']);
      } else {
        throw const ServerException(message: 'Failed to update route line');
      }
    } on DioException catch (e) {
      if (e.error is ServerException) throw e.error as ServerException;
      throw ServerException(message: e.message ?? 'Network error occurred');
    } catch (e) {
      if (e is ServerException) rethrow;
      throw ServerException(message: e.toString());
    }
  }

  @override
  Future<void> deleteRouteLine(String publicId) async {
    try {
      final response = await apiClient.delete('${ApiEndpoints.lines}$publicId/');
      if (response.statusCode != 200 && response.statusCode != 204) {
        throw const ServerException(message: 'Failed to delete route line');
      }
    } on DioException catch (e) {
      if (e.error is ServerException) throw e.error as ServerException;
      throw ServerException(message: e.message ?? 'Network error occurred');
    } catch (e) {
      if (e is ServerException) rethrow;
      throw ServerException(message: e.toString());
    }
  }
}
