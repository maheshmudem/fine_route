class PaymentMode {
  final int id;
  final String code;
  final String name;
  final String description;
  final int sortOrder;

  PaymentMode({
    required this.id,
    required this.code,
    required this.name,
    required this.description,
    required this.sortOrder,
  });
}
