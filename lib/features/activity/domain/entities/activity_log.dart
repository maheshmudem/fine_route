import 'package:equatable/equatable.dart';

class ActivityLog extends Equatable {
  final int id;
  final int user;
  final String userName;
  final String userMobile;
  final String action;
  final String targetModel;
  final String targetId;
  final String description;
  final String? ipAddress;
  final String? userAgent;
  final Map<String, dynamic> changes;
  final DateTime createdAt;

  const ActivityLog({
    required this.id,
    required this.user,
    required this.userName,
    required this.userMobile,
    required this.action,
    required this.targetModel,
    required this.targetId,
    required this.description,
    this.ipAddress,
    this.userAgent,
    required this.changes,
    required this.createdAt,
  });

  @override
  List<Object?> get props => [
        id,
        user,
        userName,
        userMobile,
        action,
        targetModel,
        targetId,
        description,
        ipAddress,
        userAgent,
        changes,
        createdAt,
      ];
}
