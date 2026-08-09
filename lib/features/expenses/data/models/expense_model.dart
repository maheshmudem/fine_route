import '../../domain/entities/expense.dart';

class ExpenseModel extends Expense {
  ExpenseModel({
    required super.publicId,
    required super.category,
    required super.categoryName,
    required super.amount,
    required super.expenseDate,
    required super.description,
    super.paymentMode,
    super.paymentModeName,
    super.receiptImage,
    required super.createdAt,
  });

  factory ExpenseModel.fromJson(Map<String, dynamic> json) {
    return ExpenseModel(
      publicId: json['public_id'],
      category: json['category'],
      categoryName: json['category_name'],
      amount: json['amount'],
      expenseDate: json['expense_date'],
      description: json['description'] ?? '',
      paymentMode: json['payment_mode'],
      paymentModeName: json['payment_mode_name'],
      receiptImage: json['receipt_image'],
      createdAt: json['created_at'],
    );
  }
}
