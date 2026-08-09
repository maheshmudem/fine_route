class Expense {
  final String publicId;
  final int category;
  final String categoryName;
  final String amount;
  final String expenseDate;
  final String description;
  final int? paymentMode;
  final String? paymentModeName;
  final String? receiptImage;
  final String createdAt;

  Expense({
    required this.publicId,
    required this.category,
    required this.categoryName,
    required this.amount,
    required this.expenseDate,
    required this.description,
    this.paymentMode,
    this.paymentModeName,
    this.receiptImage,
    required this.createdAt,
  });
}
