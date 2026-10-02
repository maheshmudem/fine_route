class OtpRequest {
  final String mobileNumber;
  final String purpose;
  final String? otp;

  OtpRequest({
    required this.mobileNumber,
    required this.purpose,
    this.otp,
  });

  Map<String, dynamic> toJson() {
    final data = <String, dynamic>{
      'mobile_number': mobileNumber,
      'purpose': purpose,
    };
    if (otp != null) {
      data['otp'] = otp;
    }
    return data;
  }
}
