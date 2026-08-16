import '../../domain/entities/session_entity.dart';

class SessionModel extends SessionEntity {
  const SessionModel({
    required super.id,
    required super.deviceName,
    required super.deviceType,
    super.ipAddress,
    required super.userAgent,
    required super.lastActivityAt,
    required super.expiresAt,
    required super.isActive,
    required super.createdAt,
  });

  factory SessionModel.fromJson(Map<String, dynamic> json) {
    return SessionModel(
      id: json['id'],
      deviceName: json['device_name'] ?? '',
      deviceType: json['device_type'] ?? '',
      ipAddress: json['ip_address'],
      userAgent: json['user_agent'] ?? '',
      lastActivityAt: DateTime.parse(json['last_activity_at']),
      expiresAt: DateTime.parse(json['expires_at']),
      isActive: json['is_active'] ?? false,
      createdAt: DateTime.parse(json['created_at']),
    );
  }
}
