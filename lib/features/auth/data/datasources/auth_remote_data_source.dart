import 'package:dio/dio.dart';
import '../../../../core/error/exceptions.dart';
import '../../../../core/network/api_client.dart';
import '../../../../core/network/api_endpoints.dart';
import '../models/login_request.dart';
import '../models/login_response.dart';

abstract class AuthRemoteDataSource {
  Future<LoginResponse> login(LoginRequest request);
  Future<void> changePassword(String oldPassword, String newPassword, String confirmPassword);
}

class AuthRemoteDataSourceImpl implements AuthRemoteDataSource {
  final ApiClient _apiClient;

  AuthRemoteDataSourceImpl(this._apiClient);

  @override
  Future<LoginResponse> login(LoginRequest request) async {
    try {
      final response = await _apiClient.post(
        ApiEndpoints.login,
        data: request.toJson(),
      );

      final loginResponse = LoginResponse.fromJson(response.data);
      if (loginResponse.success) {
        return loginResponse;
      } else {
        throw ServerException(message: loginResponse.message);
      }
    } on DioException catch (e) {
      if (e.response != null) {
        final data = e.response?.data;
        String message = 'Server Error';
        if (data is Map<String, dynamic> && data.containsKey('message')) {
          message = data['message'];
        }
        throw ServerException(message: message, statusCode: e.response?.statusCode);
      }
      throw ServerException(message: e.message ?? 'Connection error');
    } catch (e) {
      if (e is ServerException) rethrow;
      throw ServerException(message: e.toString());
    }
  }

  @override
  Future<void> changePassword(String oldPassword, String newPassword, String confirmPassword) async {
    try {
      final response = await _apiClient.post(
        ApiEndpoints.passwordChange,
        data: {
          'old_password': oldPassword,
          'new_password': newPassword,
          'confirm_password': confirmPassword,
        },
      );

      if (response.data != null && response.data['success'] == true) {
        return;
      } else {
        throw ServerException(message: response.data?['message'] ?? 'Failed to change password');
      }
    } on DioException catch (e) {
      if (e.response != null) {
        final data = e.response?.data;
        String message = 'Server Error';
        if (data is Map<String, dynamic> && data.containsKey('message')) {
          message = data['message'];
        } else if (data is Map<String, dynamic> && data.containsKey('errors')) {
           final errors = data['errors'];
           if (errors is Map && errors.isNotEmpty) {
             message = errors.values.first.toString();
           }
        }
        throw ServerException(message: message, statusCode: e.response?.statusCode);
      }
      throw ServerException(message: e.message ?? 'Connection error');
    } catch (e) {
      if (e is ServerException) rethrow;
      throw ServerException(message: e.toString());
    }
  }
}
