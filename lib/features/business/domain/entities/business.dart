import 'package:equatable/equatable.dart';

class Business extends Equatable {
  final String publicId;
  final String name;
  final String? businessCategory;
  final String mobileNumber;
  final String gstin;
  final String businessType;
  final String ownerPan;
  final String? logo;
  final String address;
  final String city;
  final String state;
  final String pinCode;
  final String subscriptionPlan;
  final String status;
  final List<String> allowedCollectionDays;
  final int maxAllowedCollectionDays;
  final DateTime? createdAt;

  const Business({
    required this.publicId,
    required this.name,
    this.businessCategory,
    required this.mobileNumber,
    required this.gstin,
    required this.businessType,
    required this.ownerPan,
    this.logo,
    required this.address,
    required this.city,
    required this.state,
    required this.pinCode,
    required this.subscriptionPlan,
    required this.status,
    required this.allowedCollectionDays,
    required this.maxAllowedCollectionDays,
    this.createdAt,
  });

  @override
  List<Object?> get props => [
        publicId,
        name,
        businessCategory,
        mobileNumber,
        gstin,
        businessType,
        ownerPan,
        logo,
        address,
        city,
        state,
        pinCode,
        subscriptionPlan,
        status,
        allowedCollectionDays,
        maxAllowedCollectionDays,
        createdAt,
      ];
}
