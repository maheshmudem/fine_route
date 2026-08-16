import 'package:dartz/dartz.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../../../core/error/exceptions.dart';
import '../../../../core/error/failures.dart';
import '../../domain/entities/auth_entity.dart';
import '../../domain/repositories/auth_repository.dart';
import '../datasources/auth_remote_data_source.dart';
import '../models/login_request.dart';

class AuthRepositoryImpl implements AuthRepository {
  final AuthRemoteDataSource _remoteDataSource;
  final FlutterSecureStorage _secureStorage;
  final SharedPreferences _sharedPreferences;

  AuthRepositoryImpl(this._remoteDataSource, this._secureStorage, this._sharedPreferences);

  @override
  Future<Either<Failure, AuthEntity>> login(LoginRequest request) async {
    try {
      final response = await _remoteDataSource.login(request);
      if (response.data != null) {
        final entity = AuthEntity(
          accessToken: response.data!.accessToken,
          refreshToken: response.data!.refreshToken,
          user: UserEntity(
            publicId: response.data!.user.publicId,
            fullName: response.data!.user.fullName,
            mobileNumber: response.data!.user.mobileNumber,
            accountType: response.data!.user.accountType,
            isMobileVerified: response.data!.user.isMobileVerified,
          ),
          workspace: WorkspaceEntity(
            publicId: response.data!.workspace.publicId,
            name: response.data!.workspace.name,
            plan: response.data!.workspace.plan,
            status: response.data!.workspace.status,
          ),
        );
        return Right(entity);
      }
      return const Left( ServerFailure(message: 'Invalid login response data'));
    } on ServerException catch (e) {
      return Left(ServerFailure(message: e.message, statusCode: e.statusCode));
    } catch (e) {
      return Left(ServerFailure(message: e.toString()));
    }
  }

  @override
  Future<void> logout() async {
    await _secureStorage.deleteAll();
    await _sharedPreferences.clear();
  }

  @override
  Future<Either<Failure, void>> changePassword(String oldPassword, String newPassword, String confirmPassword) async {
    try {
      await _remoteDataSource.changePassword(oldPassword, newPassword, confirmPassword);
      return const Right(null);
    } on ServerException catch (e) {
      return Left(ServerFailure(message: e.message));
    } catch (e) {
      return Left(ServerFailure(message: e.toString()));
    }
  }
}
