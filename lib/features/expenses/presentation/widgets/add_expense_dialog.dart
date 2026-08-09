import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import '../../../../config/theme/app_colors.dart';
import '../../../../core/widgets/app_text.dart';
import '../bloc/expenses_bloc.dart';
import '../bloc/expenses_event.dart';
import '../bloc/expenses_state.dart';

class AddExpenseDialog extends StatefulWidget {
  const AddExpenseDialog({super.key});

  static void show(BuildContext context) {
    final bloc = context.read<ExpensesBloc>();
    showDialog(
      context: context,
      builder: (_) => BlocProvider.value(
        value: bloc,
        child: const AddExpenseDialog(),
      ),
    );
  }

  @override
  State<AddExpenseDialog> createState() => _AddExpenseDialogState();
}

class _AddExpenseDialogState extends State<AddExpenseDialog> {
  final _amountController = TextEditingController();
  final _descriptionController = TextEditingController();
  int? _selectedCategory;
  int? _selectedPaymentMode;
  DateTime _selectedDate = DateTime.now();

  @override
  void dispose() {
    _amountController.dispose();
    _descriptionController.dispose();
    super.dispose();
  }

  void _submit() {
    if (_amountController.text.isEmpty || _selectedCategory == null || _selectedPaymentMode == null) {
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('Please fill all required fields')));
      return;
    }
    
    final formattedDate = "${_selectedDate.year}-${_selectedDate.month.toString().padLeft(2, '0')}-${_selectedDate.day.toString().padLeft(2, '0')}";

    context.read<ExpensesBloc>().add(SubmitExpense(
      category: _selectedCategory!,
      amount: _amountController.text,
      expenseDate: formattedDate,
      description: _descriptionController.text,
      paymentMode: _selectedPaymentMode!,
    ));
  }

  Widget _buildLabel(String text) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 8.0),
      child: AppText.bodyMedium(text, fontWeight: FontWeight.w600, color: AppColors.textHeading),
    );
  }

  InputDecoration _inputDecoration(String hint) {
    return InputDecoration(
      hintText: hint,
      hintStyle: const TextStyle(color: AppColors.textCaption, fontSize: 14),
      filled: true,
      fillColor: Colors.white,
      contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(12),
        borderSide: BorderSide(color: Colors.grey.shade300),
      ),
      enabledBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(12),
        borderSide: BorderSide(color: Colors.grey.shade300),
      ),
      focusedBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(12),
        borderSide: const BorderSide(color: AppColors.primary),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<ExpensesBloc, ExpensesState>(
      listenWhen: (prev, current) => prev.status != current.status,
      listener: (context, state) {
        if (state.status == ExpensesStatus.addSuccess) {
          final scaffoldMessenger = ScaffoldMessenger.of(context);
          Navigator.pop(context);
          scaffoldMessenger.showSnackBar(
            const SnackBar(content: Text('Expense recorded successfully.')),
          );
        } else if (state.status == ExpensesStatus.addError) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text(state.errorMessage ?? 'Failed to add expense.')),
          );
        }
      },
      builder: (context, state) {
        return Dialog(
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
          backgroundColor: const Color(0xFFF8F9FA),
          insetPadding: const EdgeInsets.all(16),
          child: SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.all(24.0),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                             AppText.headlineSmall('Log Operational Expense', fontWeight: FontWeight.bold),
                              SizedBox(height: 8),
                            AppText.bodySmall(
                              'Record fuel, agent tea/snacks, stationery, or workspace operational expenses.',
                              color: AppColors.textCaption,
                            ),
                          ],
                        ),
                      ),
                      GestureDetector(
                        onTap: () => Navigator.pop(context),
                        child: const Icon(Icons.close, color: AppColors.textCaption),
                      ),
                    ],
                  ),
                  const SizedBox(height: 24),
                  
                  Row(
                    children: [
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            _buildLabel('Expense Category *'),
                            DropdownButtonFormField<int>(
                              decoration: _inputDecoration('Select Category'),
                              initialValue: _selectedCategory,
                              icon: const Icon(Icons.keyboard_arrow_down, color: AppColors.textCaption),
                              items: state.categories.map((c) => DropdownMenuItem(value: c.id, child: Text(c.name))).toList(),
                              onChanged: (val) => setState(() => _selectedCategory = val),
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(width: 16),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            _buildLabel('Payment Mode / Option *'),
                            DropdownButtonFormField<int>(
                              decoration: _inputDecoration('Select Payment Mode'),
                              initialValue: _selectedPaymentMode,
                              icon: const Icon(Icons.keyboard_arrow_down, color: AppColors.textCaption),
                              items: state.paymentModes.map((p) => DropdownMenuItem(value: p.id, child: Text(p.name))).toList(),
                              onChanged: (val) => setState(() => _selectedPaymentMode = val),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 16),
                  
                  _buildLabel('Amount (₹) *'),
                  TextFormField(
                    controller: _amountController,
                    decoration: _inputDecoration(''),
                    keyboardType: TextInputType.number,
                  ),
                  const SizedBox(height: 16),
                  
                  _buildLabel('Expense Date *'),
                  InkWell(
                    onTap: () async {
                      final date = await showDatePicker(
                        context: context,
                        initialDate: _selectedDate,
                        firstDate: DateTime(2000),
                        lastDate: DateTime.now(),
                      );
                      if (date != null) setState(() => _selectedDate = date);
                    },
                    child: IgnorePointer(
                      child: TextFormField(
                        decoration: _inputDecoration('').copyWith(
                          suffixIcon: const Icon(Icons.calendar_today, size: 20, color: AppColors.textHeading),
                        ),
                        controller: TextEditingController(text: DateFormat('dd-MM-yyyy').format(_selectedDate)),
                      ),
                    ),
                  ),
                  const SizedBox(height: 16),
                  
                  _buildLabel('Description / Remarks *'),
                  TextFormField(
                    controller: _descriptionController,
                    decoration: _inputDecoration('e.g. Petrol for collection bike / Chai for field agents'),
                  ),
                  const SizedBox(height: 32),
                  
                  ElevatedButton(
                    onPressed: state.status == ExpensesStatus.adding ? null : _submit,
                    style: ElevatedButton.styleFrom(
                      padding: const EdgeInsets.symmetric(vertical: 16),
                      backgroundColor: const Color(0xFF003D8F),
                      foregroundColor: AppColors.textWhite,
                      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                    ),
                    child: state.status == ExpensesStatus.adding
                        ? const SizedBox(height: 20, width: 20, child: CircularProgressIndicator(color: AppColors.textWhite, strokeWidth: 2))
                        : const AppText.bodyLarge('Record Expense', color: AppColors.textWhite, fontWeight: FontWeight.bold),
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}
