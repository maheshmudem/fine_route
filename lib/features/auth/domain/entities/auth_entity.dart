import 'package:equatable/equatable.dart';

class AuthEntity extends Equatable {
  final String accessToken;
  final String refreshToken;
  final UserEntity user;
  final WorkspaceEntity workspace;

  const AuthEntity({
    required this.accessToken,
    required this.refreshToken,
    required this.user,
    required this.workspace,
  });

  @override
  List<Object?> get props => [accessToken, refreshToken, user, workspace];
}

class UserEntity extends Equatable {
  final String publicId;
  final String fullName;
  final String mobileNumber;
  final String accountType;
  final bool isMobileVerified;

  const UserEntity({
    required this.publicId,
    required this.fullName,
    required this.mobileNumber,
    required this.accountType,
    required this.isMobileVerified,
  });

  @override
  List<Object?> get props => [publicId, fullName, mobileNumber, accountType, isMobileVerified];
}

class WorkspaceEntity extends Equatable {
  final String publicId;
  final String name;
  final String plan;
  final String status;

  const WorkspaceEntity({
    required this.publicId,
    required this.name,
    required this.plan,
    required this.status,
  });

  @override
  List<Object?> get props => [publicId, name, plan, status];
}
