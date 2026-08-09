import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import '../../../../core/error/failures.dart';
import '../../../../core/usecase/usecase.dart';
import '../../data/models/login_request.dart';
import '../entities/auth_entity.dart';
import '../repositories/auth_repository.dart';

class LoginUseCase implements UseCase<AuthEntity, LoginParams> {
  final AuthRepository repository;

  LoginUseCase(this.repository);

  @override
  Future<Either<Failure, AuthEntity>> call(LoginParams params) async {
    return await repository.login(
      LoginRequest(
        identifier: params.identifier,
        password: params.password,
      ),
    );
  }
}

class LoginParams extends Equatable {
  final String identifier;
  final String password;

  const LoginParams({
    required this.identifier,
    required this.password,
  });

  @override
  List<Object> get props => [identifier, password];
}
