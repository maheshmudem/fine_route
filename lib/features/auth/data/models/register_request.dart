class RegisterRequest {
  final String fullName;
  final String mobileNumber;
  final String email;
  final String password;
  final String confirmPassword;

  RegisterRequest({
    required this.fullName,
    required this.mobileNumber,
    required this.email,
    required this.password,
    required this.confirmPassword,
  });

  Map<String, dynamic> toJson() => {
        'full_name': fullName,
        'mobile_number': mobileNumber,
        'email': email,
        'password': password,
        'confirm_password': confirmPassword,
      };
}
