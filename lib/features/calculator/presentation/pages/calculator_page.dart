import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';

import '../../../../config/theme/app_colors.dart';
import '../../../../core/widgets/app_text.dart';
import '../bloc/calculator_bloc.dart';
import '../bloc/calculator_event.dart';
import '../bloc/calculator_state.dart';

class CalculatorPage extends StatefulWidget {
  const CalculatorPage({super.key});

  @override
  State<CalculatorPage> createState() => _CalculatorPageState();
}

class _CalculatorPageState extends State<CalculatorPage> {
  Timer? _debounce;
  final currencyFormat = NumberFormat.currency(locale: 'en_IN', symbol: '₹', decimalDigits: 0);
  
  late final TextEditingController _amountController;
  late final TextEditingController _interestController;
  late final TextEditingController _durationController;

  @override
  void initState() {
    super.initState();
    final state = context.read<CalculatorBloc>().state;
    _amountController = TextEditingController(text: state.amount.toInt().toString());
    _interestController = TextEditingController(text: state.interestRate.toString());
    _durationController = TextEditingController(text: state.duration.toString());

    // Initial fetch
    context.read<CalculatorBloc>().add(CalculateLoan());
  }

  @override
  void dispose() {
    _amountController.dispose();
    _interestController.dispose();
    _durationController.dispose();
    _debounce?.cancel();
    super.dispose();
  }

  void _onInputChanged() {
    if (_debounce?.isActive ?? false) _debounce!.cancel();
    _debounce = Timer(const Duration(milliseconds: 500), () {
      if (mounted) {
        context.read<CalculatorBloc>().add(CalculateLoan());
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.scaffoldBackground,
      appBar: AppBar(
        title: const AppText.titleLarge('Smart Loan Calculator', fontWeight: FontWeight.bold),
        centerTitle: true,
        actions: [
          IconButton(
            icon: const Icon(Icons.info_outline),
            onPressed: () {},
          ),
        ],
      ),
      body: BlocBuilder<CalculatorBloc, CalculatorState>(
        builder: (context, state) {
          final calc = state.calculation;
          
          final installmentAmount = calc?.installmentAmount ?? 0.0;
          final duration = calc?.duration ?? state.duration;
          final freq = calc?.frequency.capitalize() ?? state.frequency.capitalize();

          return SingleChildScrollView(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              children: [
                // Summary Card
                Container(
                  padding: const EdgeInsets.all(20),
                  decoration: BoxDecoration(
                    color: AppColors.primary,
                    borderRadius: BorderRadius.circular(16),
                    boxShadow: [
                      BoxShadow(
                        color: AppColors.primary.withValues(alpha: 0.3),
                        blurRadius: 10,
                        offset: const Offset(0, 4),
                      ),
                    ],
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Container(
                                padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                                decoration: BoxDecoration(
                                  color: AppColors.textWhite.withValues(alpha: 0.2),
                                  borderRadius: BorderRadius.circular(12),
                                ),
                                child: AppText.labelSmall(
                                  '$freq Plan',
                                  color: AppColors.textWhite,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              const SizedBox(height: 12),
                              AppText.bodyMedium(
                                'Per ${freq.toLowerCase()} installment',
                                color: AppColors.textWhite.withValues(alpha: 0.8),
                                fontWeight: FontWeight.w500,
                              ),
                            ],
                          ),
                          Icon(Icons.account_balance_wallet, color: AppColors.textWhite.withValues(alpha: 0.6)),
                        ],
                      ),
                      const SizedBox(height: 8),
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.end,
                        children: [
                          AppText.headlineLarge(
                            currencyFormat.format(installmentAmount),
                            color: AppColors.textWhite,
                            fontWeight: FontWeight.bold,
                          ),
                        ],
                      ),
                      const SizedBox(height: 4),
                      AppText.bodySmall(
                        '× $duration installments',
                        color: AppColors.textWhite.withValues(alpha: 0.8),
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 16),
                
                // Inputs Card
                Container(
                  padding: const EdgeInsets.all(16),
                  decoration: BoxDecoration(
                    color: AppColors.cardBackground,
                    borderRadius: BorderRadius.circular(16),
                    border: Border.all(color: AppColors.divider),
                  ),
                  child: Column(
                    children: [
                      // Loan Amount
                      _buildInputRow(
                        label: 'Loan amount',
                        controller: _amountController,
                        prefixText: '₹ ',
                        onChanged: (val) {
                          final amount = double.tryParse(val);
                          if (amount != null) {
                            context.read<CalculatorBloc>().add(UpdateCalculatorValues(amount: amount));
                            _onInputChanged();
                          }
                        },
                      ),
                      const SizedBox(height: 20),
                      
                      // Interest Rate
                      _buildInputRow(
                        label: 'Interest Rate',
                        controller: _interestController,
                        suffixText: '%',
                        onChanged: (val) {
                          final interest = double.tryParse(val);
                          if (interest != null) {
                            context.read<CalculatorBloc>().add(UpdateCalculatorValues(interestRate: interest));
                            _onInputChanged();
                          }
                        },
                      ),
                      const SizedBox(height: 20),
                      
                      // Duration
                      _buildInputRow(
                        label: 'Duration (installments)',
                        controller: _durationController,
                        suffixText: ' count',
                        isInt: true,
                        onChanged: (val) {
                          final duration = int.tryParse(val);
                          if (duration != null) {
                            context.read<CalculatorBloc>().add(UpdateCalculatorValues(duration: duration));
                            _onInputChanged();
                          }
                        },
                      ),
                      const SizedBox(height: 20),
                      
                      // Frequency Dropdown
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const AppText.labelMedium(
                            'COLLECTION FREQUENCY',
                            fontWeight: FontWeight.bold,
                            color: AppColors.textCaption,
                          ),
                          const SizedBox(height: 8),
                          Container(
                            padding: const EdgeInsets.symmetric(horizontal: 16),
                            decoration: BoxDecoration(
                              color: AppColors.scaffoldBackground,
                              borderRadius: BorderRadius.circular(12),
                              border: Border.all(color: AppColors.divider),
                            ),
                            child: DropdownButtonHideUnderline(
                              child: DropdownButton<String>(
                                isExpanded: true,
                                value: state.frequency,
                                items: const [
                                  DropdownMenuItem(value: 'daily', child: AppText.bodyMedium('Daily', fontWeight: FontWeight.w500)),
                                  DropdownMenuItem(value: 'weekly', child: AppText.bodyMedium('Weekly', fontWeight: FontWeight.w500)),
                                  DropdownMenuItem(value: 'monthly', child: AppText.bodyMedium('Monthly', fontWeight: FontWeight.w500)),
                                ],
                                onChanged: (val) {
                                  if (val != null) {
                                    context.read<CalculatorBloc>().add(UpdateCalculatorValues(frequency: val));
                                    _onInputChanged();
                                  }
                                },
                              ),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 16),
                
                // Details Card
                if (calc != null)
                  Container(
                    decoration: BoxDecoration(
                      color: AppColors.cardBackground,
                      borderRadius: BorderRadius.circular(16),
                      border: Border.all(color: AppColors.divider),
                    ),
                    child: Column(
                      children: [
                        _buildDetailRow('Principal', currencyFormat.format(calc.principalAmount)),
                        const Divider(height: 1, color: AppColors.divider),
                        _buildDetailRow('Total interest', currencyFormat.format(calc.totalInterest)),
                        const Divider(height: 1, color: AppColors.divider),
                        Container(
                          color: AppColors.scaffoldBackground,
                          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              const AppText.bodyMedium('Total payable', fontWeight: FontWeight.bold),
                              AppText.bodyMedium(currencyFormat.format(calc.totalPayable), fontWeight: FontWeight.bold, color: AppColors.primary),
                            ],
                          ),
                        ),
                        const Divider(height: 1, color: AppColors.divider),
                        _buildDetailRow('Installment amount', currencyFormat.format(calc.installmentAmount)),
                        const Divider(height: 1, color: AppColors.divider),
                        _buildDetailRow('Frequency', calc.frequency.capitalize()),
                        const Divider(height: 1, color: AppColors.divider),
                        _buildDetailRow('Total Installments', calc.duration.toString()),
                      ],
                    ),
                  ),
                  
                const SizedBox(height: 16),
                if (state.status == CalculatorStatus.loading)
                  const Center(child: CircularProgressIndicator()),
                
                if (state.status == CalculatorStatus.error && state.errorMessage != null)
                  Padding(
                    padding: const EdgeInsets.only(bottom: 16),
                    child: AppText.bodyMedium(state.errorMessage!, color: AppColors.error),
                  ),

                const SizedBox(height: 16),
                
                // Buttons
                if (calc != null)
                  Row(
                    children: [
                      Expanded(
                        child: OutlinedButton.icon(
                          onPressed: () {
                            // Copy summary to clipboard
                            final summary = '''
Smart Loan Calculator Summary
-------------------------
Principal: ${currencyFormat.format(calc.principalAmount)}
Total Interest: ${currencyFormat.format(calc.totalInterest)}
Total Payable: ${currencyFormat.format(calc.totalPayable)}
Installment: ${currencyFormat.format(calc.installmentAmount)}
Frequency: ${calc.frequency.capitalize()}
Duration: ${calc.duration} installments
''';
                            Clipboard.setData(ClipboardData(text: summary));
                            ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('Summary copied to clipboard')));
                          },
                          icon: const Icon(Icons.content_copy, size: 18),
                          label: const AppText.buttonText('Copy summary'),
                          style: OutlinedButton.styleFrom(
                            padding: const EdgeInsets.symmetric(vertical: 12),
                            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                          ),
                        ),
                      ),
                      const SizedBox(width: 12),
                      Expanded(
                        child: OutlinedButton.icon(
                          onPressed: () {
                            ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('Printing schedule...')));
                          },
                          icon: const Icon(Icons.print, size: 18),
                          label: const AppText.buttonText('Print schedule'),
                          style: OutlinedButton.styleFrom(
                            padding: const EdgeInsets.symmetric(vertical: 12),
                            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                          ),
                        ),
                      ),
                    ],
                  ),
                  
                const SizedBox(height: 32),
              ],
            ),
          );
        },
      ),
    );
  }

  Widget _buildInputRow({
    required String label,
    required TextEditingController controller,
    String? prefixText,
    String? suffixText,
    required ValueChanged<String> onChanged,
    bool isInt = false,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        AppText.labelMedium(
          label.toUpperCase(),
          fontWeight: FontWeight.bold,
          color: AppColors.textCaption,
        ),
        const SizedBox(height: 8),
        TextFormField(
          controller: controller,
          keyboardType: TextInputType.numberWithOptions(decimal: !isInt),
          inputFormatters: [
            FilteringTextInputFormatter.allow(RegExp(isInt ? r'^\d+' : r'^\d+\.?\d{0,2}')),
          ],
          decoration: InputDecoration(
            prefixText: prefixText,
            suffixText: suffixText,
            contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12),
              borderSide: const BorderSide(color: AppColors.divider),
            ),
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12),
              borderSide: const BorderSide(color: AppColors.divider),
            ),
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12),
              borderSide: const BorderSide(color: AppColors.primary),
            ),
            filled: true,
            fillColor: AppColors.scaffoldBackground,
          ),
          onChanged: onChanged,
        ),
      ],
    );
  }

  Widget _buildDetailRow(String label, String value) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          AppText.bodyMedium(label, color: AppColors.textBody),
          AppText.bodyMedium(value, fontWeight: FontWeight.w600),
        ],
      ),
    );
  }
}

extension StringExtension on String {
  String capitalize() {
    if (isEmpty) return this;
    return '${this[0].toUpperCase()}${substring(1).toLowerCase()}';
  }
}
