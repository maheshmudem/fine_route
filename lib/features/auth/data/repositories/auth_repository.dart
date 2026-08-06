import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import '../../../../core/error/failures.dart';
import '../../../../core/network/api_client.dart';
import '../../../../core/network/api_endpoints.dart';
import '../models/login_request.dart';
import '../models/login_response.dart';

abstract class AuthRepository {
  Future<Either<Failure, LoginResponse>> login(LoginRequest request);
}

class AuthRepositoryImpl implements AuthRepository {
  final ApiClient _apiClient;

  AuthRepositoryImpl(this._apiClient);

  @override
  Future<Either<Failure, LoginResponse>> login(LoginRequest request) async {
    try {
      final response = await _apiClient.post(
        ApiEndpoints.login,
        data: request.toJson(),
      );

      final loginResponse = LoginResponse.fromJson(response.data);
      if (loginResponse.success) {
        return Right(loginResponse);
      } else {
        return Left(ServerFailure(message: loginResponse.message));
      }
    } on DioException catch (e) {
      if (e.response != null) {
        final data = e.response?.data;
        String message = 'Server Error';
        if (data is Map<String, dynamic> && data.containsKey('message')) {
          message = data['message'];
        }
        return Left(ServerFailure(message: message, statusCode: e.response?.statusCode));
      }
      return Left(NetworkFailure(message: e.message ?? 'Connection error'));
    } catch (e) {
      return Left(ServerFailure(message: e.toString()));
    }
  }
}
