import 'package:equatable/equatable.dart';

class Profile extends Equatable {
  final String publicId;
  final String fullName;
  final String mobileNumber;
  final String email;
  final String city;
  final String state;
  final String employeeId;
  final String accountType;
  final bool isMobileVerified;
  final bool isEmailVerified;
  final DateTime? createdAt;

  const Profile({
    required this.publicId,
    required this.fullName,
    required this.mobileNumber,
    required this.email,
    required this.city,
    required this.state,
    required this.employeeId,
    required this.accountType,
    required this.isMobileVerified,
    required this.isEmailVerified,
    this.createdAt,
  });

  @override
  List<Object?> get props => [
        publicId,
        fullName,
        mobileNumber,
        email,
        city,
        state,
        employeeId,
        accountType,
        isMobileVerified,
        isEmailVerified,
        createdAt,
      ];
}
