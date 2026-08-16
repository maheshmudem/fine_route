import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import '../../../../config/theme/app_colors.dart';
import '../../../../core/widgets/app_text.dart';
import '../../../../core/widgets/app_loader.dart';
import '../../../../di/injection_container.dart';
import '../bloc/business_bloc.dart';
import '../bloc/business_event.dart';
import '../bloc/business_state.dart';
import '../../domain/entities/business.dart';

class BusinessPage extends StatelessWidget {
  const BusinessPage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => getIt<BusinessBloc>()..add(GetBusinessEvent()),
      child: const _BusinessView(),
    );
  }
}

class _BusinessView extends StatefulWidget {
  const _BusinessView();

  @override
  State<_BusinessView> createState() => _BusinessViewState();
}

class _BusinessViewState extends State<_BusinessView> {
  final _formKey = GlobalKey<FormState>();
  late final TextEditingController _nameController;
  late final TextEditingController _gstinController;
  late final TextEditingController _typeController;
  late final TextEditingController _panController;
  late final TextEditingController _addressController;
  late final TextEditingController _cityController;
  late final TextEditingController _stateController;
  late final TextEditingController _pinController;
  
  Business? _originalBusiness;

  @override
  void initState() {
    super.initState();
    _nameController = TextEditingController();
    _gstinController = TextEditingController();
    _typeController = TextEditingController();
    _panController = TextEditingController();
    _addressController = TextEditingController();
    _cityController = TextEditingController();
    _stateController = TextEditingController();
    _pinController = TextEditingController();
  }

  @override
  void dispose() {
    _nameController.dispose();
    _gstinController.dispose();
    _typeController.dispose();
    _panController.dispose();
    _addressController.dispose();
    _cityController.dispose();
    _stateController.dispose();
    _pinController.dispose();
    super.dispose();
  }

  void _onSave() {
    if (_formKey.currentState!.validate() && _originalBusiness != null) {
      final changedFields = <String, dynamic>{};

      if (_nameController.text.trim() != _originalBusiness!.name) {
        changedFields['name'] = _nameController.text.trim();
      }
      if (_gstinController.text.trim() != _originalBusiness!.gstin) {
        changedFields['gstin'] = _gstinController.text.trim();
      }
      if (_typeController.text.trim() != _originalBusiness!.businessType) {
        changedFields['business_type'] = _typeController.text.trim();
      }
      if (_panController.text.trim() != _originalBusiness!.ownerPan) {
        changedFields['owner_pan'] = _panController.text.trim();
      }
      if (_addressController.text.trim() != _originalBusiness!.address) {
        changedFields['address'] = _addressController.text.trim();
      }
      if (_cityController.text.trim() != _originalBusiness!.city) {
        changedFields['city'] = _cityController.text.trim();
      }
      if (_stateController.text.trim() != _originalBusiness!.state) {
        changedFields['state'] = _stateController.text.trim();
      }
      if (_pinController.text.trim() != _originalBusiness!.pinCode) {
        changedFields['pin_code'] = _pinController.text.trim();
      }

      if (changedFields.isEmpty) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('No changes to save'), backgroundColor: AppColors.textBody),
        );
        return;
      }

      context.read<BusinessBloc>().add(
        UpdateBusinessEvent(changedFields: changedFields),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<BusinessBloc, BusinessState>(
      listener: (context, state) {
        if (state is BusinessUpdateSuccess) {
          _originalBusiness = state.business;
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(content: Text('Business updated successfully'), backgroundColor: AppColors.success),
          );
        } else if (state is BusinessUpdateError) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text(state.message), backgroundColor: AppColors.error),
          );
        } else if (state is BusinessLoaded) {
          final business = state.business;
          _originalBusiness = business;
          _nameController.text = business.name;
          _gstinController.text = business.gstin;
          _typeController.text = business.businessType;
          _panController.text = business.ownerPan;
          _addressController.text = business.address;
          _cityController.text = business.city;
          _stateController.text = business.state;
          _pinController.text = business.pinCode;
        }
      },
      builder: (context, state) {
        return Scaffold(
          backgroundColor: AppColors.scaffoldBackground,
          appBar: AppBar(
            title: const AppText.headlineSmall('Business', color: AppColors.textHeading),
            centerTitle: true,
            elevation: 0,
            backgroundColor: AppColors.surfaceColor,
            iconTheme: const IconThemeData(color: AppColors.textHeading),
          ),
          body: _buildBody(state),
        );
      },
    );
  }

  Widget _buildBody(BusinessState state) {
    if (state is BusinessLoading) {
      return const Center(child: AppLoader());
    } else if (state is BusinessError) {
      return Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            AppText.bodyMedium(state.message, color: AppColors.error),
            const SizedBox(height: 16),
            ElevatedButton(
              onPressed: () => context.read<BusinessBloc>().add(GetBusinessEvent()),
              child: const Text('Retry'),
            ),
          ],
        ),
      );
    }
    
    // Loaded, Updating, UpdateSuccess, UpdateError all show the form
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
                      return Column(
                        children: [
                          if (isWide)
                            Row(
                              children: [
                                Expanded(child: _buildFormField('Business name', _nameController, 'Enter business name')),
                                const SizedBox(width: 24),
                                Expanded(child: _buildFormField('GSTIN', _gstinController, 'Enter GSTIN (e.g. 08AAACS1234)')),
                              ],
                            )
                          else ...[
                            _buildFormField('Business name', _nameController, 'Enter business name'),
                            const SizedBox(height: 16),
                            _buildFormField('GSTIN', _gstinController, 'Enter GSTIN (e.g. 08AAACS1234)'),
                          ],
                          const SizedBox(height: 16),
                          if (isWide)
                            Row(
                              children: [
                                Expanded(child: _buildFormField('Business type', _typeController, 'e.g. Daily Finance')),
                                const SizedBox(width: 24),
                                Expanded(child: _buildFormField('Owner PAN', _panController, 'Enter PAN (e.g. ABCDE1234F)')),
                              ],
                            )
                          else ...[
                            _buildFormField('Business type', _typeController, 'e.g. Daily Finance'),
                            const SizedBox(height: 16),
                            _buildFormField('Owner PAN', _panController, 'Enter PAN (e.g. ABCDE1234F)'),
                          ],
                        ],
                      );
                    },
                  ),
                  const SizedBox(height: 16),
                  _buildFormField('Address', _addressController, 'Enter street address'),
                  const SizedBox(height: 16),
                  LayoutBuilder(
                    builder: (context, constraints) {
                      final isWide = constraints.maxWidth > 600;
                      return Column(
                        children: [
                          if (isWide)
                            Row(
                              children: [
                                Expanded(child: _buildFormField('City', _cityController, 'Enter city')),
                                const SizedBox(width: 24),
                                Expanded(child: _buildFormField('State', _stateController, 'Enter state')),
                              ],
                            )
                          else ...[
                            _buildFormField('City', _cityController, 'Enter city'),
                            const SizedBox(height: 16),
                            _buildFormField('State', _stateController, 'Enter state'),
                          ],
                        ],
                      );
                    },
                  ),
                  const SizedBox(height: 16),
                  _buildFormField('Pin Code', _pinController, 'Enter pincode'),
                  const SizedBox(height: 48),
                  Align(
                    alignment: Alignment.centerRight,
                    child: ElevatedButton(
                      onPressed: state is BusinessUpdating ? null : _onSave,
                      style: ElevatedButton.styleFrom(
                        backgroundColor: AppColors.primary,
                        foregroundColor: AppColors.textWhite,
                        padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 16),
                        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
                      ),
                      child: state is BusinessUpdating
                          ? const SizedBox(
                              width: 20,
                              height: 20,
                              child: CircularProgressIndicator(color: AppColors.textWhite, strokeWidth: 2),
                            )
                          : const Text('Save Business Changes', style: TextStyle(fontWeight: FontWeight.bold)),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildFormField(String label, TextEditingController controller, String hintText) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        AppText.bodyMedium(label, fontWeight: FontWeight.bold, color: AppColors.textHeading),
        const SizedBox(height: 8),
        TextFormField(
          controller: controller,
          decoration: InputDecoration(
            hintText: hintText,
            hintStyle: TextStyle(color: AppColors.textBody.withValues(alpha: 0.5)),
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
          ),
        ),
      ],
    );
  }
}
