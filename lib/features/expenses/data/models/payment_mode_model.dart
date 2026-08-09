import '../../domain/entities/payment_mode.dart';

class PaymentModeModel extends PaymentMode {
  PaymentModeModel({
    required super.id,
    required super.code,
    required super.name,
    required super.description,
    required super.sortOrder,
  });

  factory PaymentModeModel.fromJson(Map<String, dynamic> json) {
    return PaymentModeModel(
      id: json['id'],
      code: json['code'],
      name: json['name'],
      description: json['description'] ?? '',
      sortOrder: json['sort_order'] ?? 0,
    );
  }
}
