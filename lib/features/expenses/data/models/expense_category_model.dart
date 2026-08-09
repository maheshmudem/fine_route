import '../../domain/entities/expense_category.dart';

class ExpenseCategoryModel extends ExpenseCategory {
  ExpenseCategoryModel({
    required super.id,
    required super.code,
    required super.name,
    required super.isSystem,
  });

  factory ExpenseCategoryModel.fromJson(Map<String, dynamic> json) {
    return ExpenseCategoryModel(
      id: json['id'],
      code: json['code'],
      name: json['name'],
      isSystem: json['is_system'] ?? false,
    );
  }
}
