import '../../domain/entities/business.dart';

class BusinessModel extends Business {
  const BusinessModel({
    required super.publicId,
    required super.name,
    super.businessCategory,
    required super.mobileNumber,
    required super.gstin,
    required super.businessType,
    required super.ownerPan,
    super.logo,
    required super.address,
    required super.city,
    required super.state,
    required super.pinCode,
    required super.subscriptionPlan,
    required super.status,
    required super.allowedCollectionDays,
    required super.maxAllowedCollectionDays,
    super.createdAt,
  });

  factory BusinessModel.fromJson(Map<String, dynamic> json) {
    return BusinessModel(
      publicId: json['public_id'] ?? '',
      name: json['name'] ?? '',
      businessCategory: json['business_category'],
      mobileNumber: json['mobile_number'] ?? '',
      gstin: json['gstin'] ?? '',
      businessType: json['business_type'] ?? '',
      ownerPan: json['owner_pan'] ?? '',
      logo: json['logo'],
      address: json['address'] ?? '',
      city: json['city'] ?? '',
      state: json['state'] ?? '',
      pinCode: json['pin_code'] ?? '',
      subscriptionPlan: json['subscription_plan'] ?? '',
      status: json['status'] ?? '',
      allowedCollectionDays: (json['allowed_collection_days'] as List<dynamic>?)
              ?.map((e) => e.toString())
              .toList() ??
          [],
      maxAllowedCollectionDays: json['max_allowed_collection_days'] ?? 0,
      createdAt: json['created_at'] != null ? DateTime.parse(json['created_at']) : null,
    );
  }
}
