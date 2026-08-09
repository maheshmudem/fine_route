import '../../domain/entities/profile.dart';

class ProfileModel extends Profile {
  const ProfileModel({
    required super.publicId,
    required super.fullName,
    required super.mobileNumber,
    required super.email,
    required super.city,
    required super.state,
    required super.employeeId,
    required super.accountType,
    required super.isMobileVerified,
    required super.isEmailVerified,
    super.createdAt,
  });

  factory ProfileModel.fromJson(Map<String, dynamic> json) {
    return ProfileModel(
      publicId: json['public_id'] ?? '',
      fullName: json['full_name'] ?? '',
      mobileNumber: json['mobile_number'] ?? '',
      email: json['email'] ?? '',
      city: json['city'] ?? '',
      state: json['state'] ?? '',
      employeeId: json['employee_id'] ?? '',
      accountType: json['account_type'] ?? '',
      isMobileVerified: json['is_mobile_verified'] ?? false,
      isEmailVerified: json['is_email_verified'] ?? false,
      createdAt: json['created_at'] != null ? DateTime.parse(json['created_at']) : null,
    );
  }
}
