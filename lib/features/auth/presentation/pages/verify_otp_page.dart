import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import '../../../../core/widgets/app_button.dart';
import '../../../../core/widgets/app_text.dart';
import '../../../../core/widgets/app_text_field.dart';
import '../../../../di/injection_container.dart';
import '../bloc/register_bloc.dart';
import '../bloc/register_event.dart';
import '../bloc/register_state.dart';

class VerifyOtpPage extends StatelessWidget {
  final String mobileNumber;

  const VerifyOtpPage({super.key, required this.mobileNumber});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => getIt<RegisterBloc>(),
      child: _VerifyOtpView(mobileNumber: mobileNumber),
    );
  }
}

class _VerifyOtpView extends StatefulWidget {
  final String mobileNumber;

  const _VerifyOtpView({required this.mobileNumber});

  @override
  State<_VerifyOtpView> createState() => _VerifyOtpViewState();
}

class _VerifyOtpViewState extends State<_VerifyOtpView> {
  final _formKey = GlobalKey<FormState>();
  final _otpController = TextEditingController();

  @override
  void dispose() {
    _otpController.dispose();
    super.dispose();
  }

  void _onVerifyPressed() {
    if (_formKey.currentState?.validate() ?? false) {
      context.read<RegisterBloc>().add(
            SubmitOtpVerificationEvent(
              mobileNumber: widget.mobileNumber,
              purpose: 'registration',
              otp: _otpController.text.trim(),
            ),
          );
    }
  }

  void _onResendPressed() {
    context.read<RegisterBloc>().add(
          ResendOtpEvent(
            mobileNumber: widget.mobileNumber,
            purpose: 'registration',
          ),
        );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const AppText.headlineSmall('Verify OTP'),
        centerTitle: true,
      ),
      body: SafeArea(
        child: Center(
          child: SingleChildScrollView(
            padding: const EdgeInsets.all(24.0),
            child: Form(
              key: _formKey,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  AppText.bodyMedium(
                    'Please enter the 6-digit OTP sent to ${widget.mobileNumber}',
                    textAlign: TextAlign.center,
                  ),
                  const SizedBox(height: 32),
                  AppTextField(
                    controller: _otpController,
                    label: 'Enter OTP',
                    keyboardType: TextInputType.number,
                    validator: (value) {
                      if (value == null || value.trim().isEmpty) {
                        return 'Please enter the OTP';
                      }
                      if (value.trim().length != 6) {
                        return 'OTP must be 6 digits';
                      }
                      return null;
                    },
                  ),
                  const SizedBox(height: 32),
                  BlocConsumer<RegisterBloc, RegisterState>(
                    listener: (context, state) {
                      if (state is OtpVerifySuccess) {
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(content: Text(state.message)),
                        );
                        // Navigate back to login
                        context.go('/login');
                      } else if (state is OtpResendSuccess) {
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(content: Text(state.message)),
                        );
                      } else if (state is RegisterError) {
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(
                            content: Text(state.message),
                            backgroundColor: Colors.red,
                          ),
                        );
                      }
                    },
                    builder: (context, state) {
                      return Column(
                        crossAxisAlignment: CrossAxisAlignment.stretch,
                        children: [
                          AppButton(
                            label: 'Verify OTP',
                            isLoading: state is RegisterLoading,
                            onPressed: _onVerifyPressed,
                          ),
                          const SizedBox(height: 16),
                          TextButton(
                            onPressed: state is RegisterLoading ? null : _onResendPressed,
                            child: const AppText.bodyMedium('Resend OTP', color: Colors.blue),
                          ),
                        ],
                      );
                    },
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
