class LoginResponse {
  final bool success;
  final String message;
  final LoginData? data;

  LoginResponse({
    required this.success,
    required this.message,
    this.data,
  });

  factory LoginResponse.fromJson(Map<String, dynamic> json) {
    return LoginResponse(
      success: json['success'] ?? false,
      message: json['message'] ?? '',
      data: json['data'] != null ? LoginData.fromJson(json['data']) : null,
    );
  }
}

class LoginData {
  final String accessToken;
  final String refreshToken;
  final UserData user;
  final WorkspaceData workspace;

  LoginData({
    required this.accessToken,
    required this.refreshToken,
    required this.user,
    required this.workspace,
  });

  factory LoginData.fromJson(Map<String, dynamic> json) {
    return LoginData(
      accessToken: json['access_token'] ?? '',
      refreshToken: json['refresh_token'] ?? '',
      user: UserData.fromJson(json['user'] ?? {}),
      workspace: WorkspaceData.fromJson(json['workspace'] ?? {}),
    );
  }
}

class UserData {
  final String publicId;
  final String fullName;
  final String mobileNumber;
  final String accountType;
  final bool isMobileVerified;

  UserData({
    required this.publicId,
    required this.fullName,
    required this.mobileNumber,
    required this.accountType,
    required this.isMobileVerified,
  });

  factory UserData.fromJson(Map<String, dynamic> json) {
    return UserData(
      publicId: json['public_id'] ?? '',
      fullName: json['full_name'] ?? '',
      mobileNumber: json['mobile_number'] ?? '',
      accountType: json['account_type'] ?? '',
      isMobileVerified: json['is_mobile_verified'] ?? false,
    );
  }
}

class WorkspaceData {
  final String publicId;
  final String name;
  final String plan;
  final String status;

  WorkspaceData({
    required this.publicId,
    required this.name,
    required this.plan,
    required this.status,
  });

  factory WorkspaceData.fromJson(Map<String, dynamic> json) {
    return WorkspaceData(
      publicId: json['public_id'] ?? '',
      name: json['name'] ?? '',
      plan: json['plan'] ?? '',
      status: json['status'] ?? '',
    );
  }
}
