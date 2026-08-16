import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import '../../../../config/theme/app_colors.dart';
import '../../../../core/widgets/app_text.dart';
import '../../../../di/injection_container.dart';
import '../bloc/change_password_bloc.dart';
import '../bloc/change_password_event.dart';
import '../bloc/change_password_state.dart';

class ChangePasswordPage extends StatelessWidget {
  const ChangePasswordPage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => getIt<ChangePasswordBloc>(),
      child: const _ChangePasswordView(),
    );
  }
}

class _ChangePasswordView extends StatefulWidget {
  const _ChangePasswordView();

  @override
  State<_ChangePasswordView> createState() => _ChangePasswordViewState();
}

class _ChangePasswordViewState extends State<_ChangePasswordView> {
  final _formKey = GlobalKey<FormState>();
  final _currentPasswordController = TextEditingController();
  final _newPasswordController = TextEditingController();
  final _confirmPasswordController = TextEditingController();

  bool _obscureCurrent = true;
  bool _obscureNew = true;
  bool _obscureConfirm = true;

  @override
  void dispose() {
    _currentPasswordController.dispose();
    _newPasswordController.dispose();
    _confirmPasswordController.dispose();
    super.dispose();
  }

  void _onSubmit() {
    if (_formKey.currentState!.validate()) {
      context.read<ChangePasswordBloc>().add(
        SubmitChangePasswordEvent(
          oldPassword: _currentPasswordController.text,
          newPassword: _newPasswordController.text,
          confirmPassword: _confirmPasswordController.text,
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.scaffoldBackground,
      appBar: AppBar(
        title: const AppText.headlineSmall('Change Password', color: AppColors.textHeading),
        centerTitle: true,
        elevation: 0,
        backgroundColor: AppColors.surfaceColor,
        iconTheme: const IconThemeData(color: AppColors.textHeading),
      ),
      body: BlocConsumer<ChangePasswordBloc, ChangePasswordState>(
        listener: (context, state) {
          if (state is ChangePasswordSuccess) {
            ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(content: Text('Password changed successfully!'), backgroundColor: AppColors.success),
            );
            context.pop();
          } else if (state is ChangePasswordError) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(content: Text(state.message), backgroundColor: AppColors.error),
            );
          }
        },
        builder: (context, state) {
          return SafeArea(
            child: SingleChildScrollView(
              padding: const EdgeInsets.all(24.0),
              child: Form(
                key: _formKey,
                child: Card(
                  elevation: 0,
                  color: AppColors.surfaceColor,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(16),
                    side: const BorderSide(color: AppColors.border),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(24.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: [
                        LayoutBuilder(
                          builder: (context, constraints) {
                            final isWide = constraints.maxWidth > 600;
                            if (isWide) {
                              return Row(
                                children: [
                                  Expanded(
                                    child: _buildPasswordField(
                                      label: 'Current password',
                                      controller: _currentPasswordController,
                                      obscureText: _obscureCurrent,
                                      onToggleObscure: () => setState(() => _obscureCurrent = !_obscureCurrent),
                                      validator: (val) => val == null || val.isEmpty ? 'Required' : null,
                                    ),
                                  ),
                                  const SizedBox(width: 24),
                                  Expanded(
                                    child: _buildPasswordField(
                                      label: 'New password',
                                      controller: _newPasswordController,
                                      obscureText: _obscureNew,
                                      onToggleObscure: () => setState(() => _obscureNew = !_obscureNew),
                                      validator: (val) {
                                        if (val == null || val.isEmpty) return 'Required';
                                        if (val.length < 8) return 'Minimum 8 characters';
                                        return null;
                                      },
                                    ),
                                  ),
                                ],
                              );
                            } else {
                              return Column(
                                children: [
                                  _buildPasswordField(
                                    label: 'Current password',
                                    controller: _currentPasswordController,
                                    obscureText: _obscureCurrent,
                                    onToggleObscure: () => setState(() => _obscureCurrent = !_obscureCurrent),
                                    validator: (val) => val == null || val.isEmpty ? 'Required' : null,
                                  ),
                                  const SizedBox(height: 24),
                                  _buildPasswordField(
                                    label: 'New password',
                                    controller: _newPasswordController,
                                    obscureText: _obscureNew,
                                    onToggleObscure: () => setState(() => _obscureNew = !_obscureNew),
                                    validator: (val) {
                                      if (val == null || val.isEmpty) return 'Required';
                                      if (val.length < 8) return 'Minimum 8 characters';
                                      return null;
                                    },
                                  ),
                                ],
                              );
                            }
                          },
                        ),
                        const SizedBox(height: 24),
                        _buildPasswordField(
                          label: 'Confirm new password',
                          controller: _confirmPasswordController,
                          obscureText: _obscureConfirm,
                          onToggleObscure: () => setState(() => _obscureConfirm = !_obscureConfirm),
                          validator: (val) {
                            if (val == null || val.isEmpty) return 'Required';
                            if (val != _newPasswordController.text) return 'Passwords do not match';
                            return null;
                          },
                        ),
                        const SizedBox(height: 48),
                        LayoutBuilder(
                          builder: (context, constraints) {
                            final isWide = constraints.maxWidth > 400;
                            final authText = Row(
                              children: [
                                AppText.bodyMedium('Two-factor authentication is ', color: AppColors.textBody),
                                const AppText.bodyMedium('enabled.', color: AppColors.success, fontWeight: FontWeight.bold),
                              ],
                            );
                            final button = ElevatedButton(
                              onPressed: state is ChangePasswordLoading ? null : _onSubmit,
                              style: ElevatedButton.styleFrom(
                                backgroundColor: const Color(0xFF0D47A1), // Dark blue from reference image
                                foregroundColor: AppColors.textWhite,
                                padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 16),
                                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
                              ),
                              child: state is ChangePasswordLoading
                                  ? const SizedBox(
                                      width: 20,
                                      height: 20,
                                      child: CircularProgressIndicator(color: AppColors.textWhite, strokeWidth: 2),
                                    )
                                  : const Text('Update Password', style: TextStyle(fontWeight: FontWeight.bold)),
                            );

                            if (isWide) {
                              return Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                  authText,
                                  button,
                                ],
                              );
                            } else {
                              return Column(
                                crossAxisAlignment: CrossAxisAlignment.stretch,
                                children: [
                                  authText,
                                  const SizedBox(height: 16),
                                  button,
                                ],
                              );
                            }
                          },
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          );
        },
      ),
    );
  }

  Widget _buildPasswordField({
    required String label,
    required TextEditingController controller,
    required bool obscureText,
    required VoidCallback onToggleObscure,
    required String? Function(String?) validator,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        AppText.bodyMedium(label, color: AppColors.textHeading),
        const SizedBox(height: 8),
        TextFormField(
          controller: controller,
          obscureText: obscureText,
          obscuringCharacter: '•',
          decoration: InputDecoration(
            filled: true,
            fillColor: AppColors.surfaceColor,
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(8),
              borderSide: const BorderSide(color: AppColors.border),
            ),
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(8),
              borderSide: const BorderSide(color: AppColors.border),
            ),
            contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
            suffixIcon: IconButton(
              icon: Icon(
                obscureText ? Icons.visibility_off_outlined : Icons.visibility_outlined,
                color: AppColors.iconColor,
                size: 20,
              ),
              onPressed: onToggleObscure,
            ),
          ),
          validator: validator,
        ),
      ],
    );
  }
}
