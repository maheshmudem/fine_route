import 'package:equatable/equatable.dart';

class SessionEntity extends Equatable {
  final int id;
  final String deviceName;
  final String deviceType;
  final String? ipAddress;
  final String userAgent;
  final DateTime lastActivityAt;
  final DateTime expiresAt;
  final bool isActive;
  final DateTime createdAt;

  const SessionEntity({
    required this.id,
    required this.deviceName,
    required this.deviceType,
    this.ipAddress,
    required this.userAgent,
    required this.lastActivityAt,
    required this.expiresAt,
    required this.isActive,
    required this.createdAt,
  });

  @override
  List<Object?> get props => [
        id,
        deviceName,
        deviceType,
        ipAddress,
        userAgent,
        lastActivityAt,
        expiresAt,
        isActive,
        createdAt,
      ];
}
