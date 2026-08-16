import '../../domain/entities/activity_log.dart';

class ActivityLogModel extends ActivityLog {
  const ActivityLogModel({
    required super.id,
    required super.user,
    required super.userName,
    required super.userMobile,
    required super.action,
    required super.targetModel,
    required super.targetId,
    required super.description,
    super.ipAddress,
    super.userAgent,
    required super.changes,
    required super.createdAt,
  });

  factory ActivityLogModel.fromJson(Map<String, dynamic> json) {
    return ActivityLogModel(
      id: json['id'],
      user: json['user'],
      userName: json['user_name'] ?? '',
      userMobile: json['user_mobile'] ?? '',
      action: json['action'] ?? '',
      targetModel: json['target_model'] ?? '',
      targetId: json['target_id']?.toString() ?? '',
      description: json['description'] ?? '',
      ipAddress: json['ip_address'],
      userAgent: json['user_agent'],
      changes: json['changes'] is Map ? Map<String, dynamic>.from(json['changes']) : {},
      createdAt: DateTime.parse(json['created_at']),
    );
  }
}
