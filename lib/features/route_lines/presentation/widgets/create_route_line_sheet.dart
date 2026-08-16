import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import '../../../../config/theme/app_colors.dart';
import '../../../../core/widgets/app_text.dart';
import '../../../../core/widgets/app_loader.dart';
import '../../domain/entities/route_line_entity.dart';
import '../bloc/create_route_line/create_route_line_bloc.dart';
import '../bloc/create_route_line/create_route_line_event.dart';
import '../bloc/create_route_line/create_route_line_state.dart';

class CreateRouteLineSheet extends StatefulWidget {
  final RouteLineEntity? existingLine;
  const CreateRouteLineSheet({super.key, this.existingLine});

  @override
  State<CreateRouteLineSheet> createState() => _CreateRouteLineSheetState();
}

class _CreateRouteLineSheetState extends State<CreateRouteLineSheet> {
  final _nameController = TextEditingController();
  final _areaController = TextEditingController();
  final Map<String, String> _selectedPortions = {};
  Map<String, List<String>> _availablePortions = {};

  final List<String> _daysOfWeek = [
    'monday', 'tuesday', 'wednesday', 'thursday', 'friday', 'saturday', 'sunday'
  ];

  @override
  void initState() {
    super.initState();
    if (widget.existingLine != null) {
      _nameController.text = widget.existingLine!.name;
      _areaController.text = widget.existingLine!.area;
      for (var schedule in widget.existingLine!.daySchedules) {
        _selectedPortions[schedule.dayOfWeek] = schedule.portion;
      }
    }
    context.read<CreateRouteLineBloc>().add(LoadAvailablePortionsEvent(
      excludeLineId: widget.existingLine?.publicId,
    ));
  }

  @override
  void dispose() {
    _nameController.dispose();
    _areaController.dispose();
    super.dispose();
  }

  void _submit() {
    if (_nameController.text.trim().isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Route name is required'), backgroundColor: AppColors.error),
      );
      return;
    }

    final schedules = _selectedPortions.entries.map((e) => DayScheduleEntity(
      dayOfWeek: e.key,
      portion: e.value,
    )).toList();

    if (widget.existingLine != null) {
      context.read<CreateRouteLineBloc>().add(UpdateRouteLineEvent(
        publicId: widget.existingLine!.publicId,
        name: _nameController.text.trim(),
        area: _areaController.text.trim(),
        schedules: schedules,
      ));
    } else {
      context.read<CreateRouteLineBloc>().add(SubmitRouteLineEvent(
        name: _nameController.text.trim(),
        area: _areaController.text.trim(),
        schedules: schedules,
      ));
    }
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<CreateRouteLineBloc, CreateRouteLineState>(
      listener: (context, state) {
        if (state is CreateRouteLinePortionsLoaded) {
          setState(() {
            _availablePortions = state.availablePortions;
          });
        } else if (state is CreateRouteLineSuccess) {
          context.pop(true); // Return true to indicate success
        } else if (state is CreateRouteLineError) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text(state.message), backgroundColor: AppColors.error),
          );
        }
      },
      child: Container(
        height: MediaQuery.of(context).size.height * 0.9,
        decoration: const BoxDecoration(
          color: AppColors.scaffoldBackground,
          borderRadius: BorderRadius.vertical(top: Radius.circular(16)),
        ),
        child: Column(
          children: [
            _buildHeader(),
            Expanded(
              child: SingleChildScrollView(
                padding: const EdgeInsets.all(16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    AppText.bodySmall(
                      'Set up your collection route name, area details, and assigned day time slots.',
                      color: AppColors.textBody.withValues(alpha: 0.8),
                    ),
                    const SizedBox(height: 16),
                    _buildInputs(),
                    const SizedBox(height: 24),
                    _buildSchedulesSection(),
                  ],
                ),
              ),
            ),
            _buildFooter(),
          ],
        ),
      ),
    );
  }

  Widget _buildHeader() {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
      decoration: BoxDecoration(
        color: AppColors.surfaceColor,
        borderRadius: const BorderRadius.vertical(top: Radius.circular(16)),
        border: Border(bottom: BorderSide(color: AppColors.border)),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Row(
            children: [
              IconButton(
                icon: const Icon(Icons.arrow_back, color: AppColors.textBody),
                onPressed: () => context.pop(),
                constraints: const BoxConstraints(),
                padding: EdgeInsets.zero,
              ),
              const SizedBox(width: 12),
              AppText.titleMedium(
                widget.existingLine != null ? 'Edit Collection Line (Route)' : 'Configure Collection Line', 
                fontWeight: FontWeight.bold, 
                color: AppColors.textHeading,
              ),
            ],
          ),
          IconButton(
            icon: const Icon(Icons.close, color: AppColors.textBody),
            onPressed: () => context.pop(),
            constraints: const BoxConstraints(),
            padding: EdgeInsets.zero,
          ),
        ],
      ),
    );
  }

  Widget _buildInputs() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const AppText.labelMedium('Line / Business Route Name *', fontWeight: FontWeight.bold, color: AppColors.textHeading),
        const SizedBox(height: 8),
        TextField(
          controller: _nameController,
          decoration: InputDecoration(
            hintText: 'e.g. Line 1 — Market Area',
            hintStyle: TextStyle(color: AppColors.textBody.withValues(alpha: 0.5), fontSize: 14),
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(8),
              borderSide: const BorderSide(color: AppColors.primary),
            ),
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(8),
              borderSide: const BorderSide(color: AppColors.primary, width: 2),
            ),
            contentPadding: const EdgeInsets.symmetric(horizontal: 12, vertical: 12),
          ),
        ),
        const SizedBox(height: 16),
        const AppText.labelMedium('Area / Locality Details', fontWeight: FontWeight.bold, color: AppColors.textHeading),
        const SizedBox(height: 8),
        TextField(
          controller: _areaController,
          decoration: InputDecoration(
            hintText: 'e.g. Kukatpally Sector 4, Main Road',
            hintStyle: TextStyle(color: AppColors.textBody.withValues(alpha: 0.5), fontSize: 14),
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(8),
              borderSide: BorderSide(color: AppColors.border),
            ),
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(8),
              borderSide: const BorderSide(color: AppColors.primary, width: 2),
            ),
            contentPadding: const EdgeInsets.symmetric(horizontal: 12, vertical: 12),
          ),
        ),
      ],
    );
  }

  Widget _buildSchedulesSection() {
    return BlocBuilder<CreateRouteLineBloc, CreateRouteLineState>(
      builder: (context, state) {
        if (state is CreateRouteLineLoadingPortions) {
          return const Padding(
            padding: EdgeInsets.all(32),
            child: Center(child: AppLoader()),
          );
        } else if (_availablePortions.isNotEmpty) {
          return Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  const Icon(Icons.calendar_today, size: 20, color: AppColors.primary),
                  const SizedBox(width: 8),
                  const AppText.titleMedium('Assign Days & Time Portions', fontWeight: FontWeight.bold, color: AppColors.textHeading),
                ],
              ),
              const SizedBox(height: 4),
              AppText.labelSmall('Select Morning (1am-1pm), Afternoon (1pm-12am), or Both', color: AppColors.textBody.withValues(alpha: 0.8)),
              const SizedBox(height: 16),
              ..._daysOfWeek.map((day) => _buildDayRow(day, _availablePortions[day] ?? [])),
            ],
          );
        } else if (state is CreateRouteLineError) {
          return AppText.bodyMedium(state.message, color: AppColors.error);
        }
        return const SizedBox.shrink();
      },
    );
  }

  Widget _buildDayRow(String day, List<String> availablePortions) {
    final formattedDay = day[0].toUpperCase() + day.substring(1);
    
    // We always render all three chips
    final portionsList = ['morning', 'afternoon', 'both'];

    return Container(
      margin: const EdgeInsets.only(bottom: 12),
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        border: Border.all(color: AppColors.border),
        borderRadius: BorderRadius.circular(8),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              AppText.labelLarge(formattedDay, fontWeight: FontWeight.bold, color: AppColors.textHeading),
              if (_selectedPortions.containsKey(day))
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 4),
                  decoration: BoxDecoration(
                    color: Colors.green.withValues(alpha: 0.1),
                    borderRadius: BorderRadius.circular(16),
                    border: Border.all(color: Colors.green.withValues(alpha: 0.3)),
                  ),
                  child: const AppText.labelSmall('Selected', color: Colors.green, fontWeight: FontWeight.bold),
                ),
            ],
          ),
          const SizedBox(height: 12),
          Row(
            children: portionsList.map((portion) {
              final isAvailable = availablePortions.contains(portion);
              
              // Determine if this chip should look active
              bool isSelected = false;
              if (portion == 'both') {
                isSelected = _selectedPortions[day] == 'both';
              } else if (portion == 'morning') {
                isSelected = _selectedPortions[day] == 'morning' || _selectedPortions[day] == 'both';
              } else if (portion == 'afternoon') {
                isSelected = _selectedPortions[day] == 'afternoon' || _selectedPortions[day] == 'both';
              }

              IconData? icon;
              if (portion == 'morning') icon = Icons.wb_sunny_outlined;
              if (portion == 'afternoon') icon = Icons.nights_stay_outlined;

              final displayPortion = portion == 'both' ? 'Full Day' : portion;
              final formattedPortion = displayPortion[0].toUpperCase() + displayPortion.substring(1);

              return Expanded(
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 4),
                  child: InkWell(
                    onTap: isAvailable ? () {
                      setState(() {
                        if (_selectedPortions[day] == portion) {
                          _selectedPortions.remove(day); // Deselect if tapping the currently selected primary portion
                        } else {
                          _selectedPortions[day] = portion; // Otherwise, set it to the tapped portion
                        }
                      });
                    } : null,
                    borderRadius: BorderRadius.circular(8),
                    child: Container(
                      padding: const EdgeInsets.symmetric(vertical: 8),
                      decoration: BoxDecoration(
                        color: isSelected ? AppColors.primary.withValues(alpha: 0.1) : AppColors.surfaceColor,
                        border: Border.all(
                          color: isSelected 
                              ? AppColors.primary 
                              : isAvailable ? AppColors.border : AppColors.border.withValues(alpha: 0.3),
                          width: isSelected ? 1.5 : 1,
                        ),
                        borderRadius: BorderRadius.circular(8),
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          if (icon != null) ...[
                            Icon(
                              icon, 
                              size: 14, 
                              color: isSelected 
                                  ? AppColors.primary 
                                  : isAvailable ? AppColors.textBody : AppColors.textBody.withValues(alpha: 0.3)
                            ),
                            const SizedBox(width: 4),
                          ],
                          Text(
                            formattedPortion,
                            style: TextStyle(
                              fontSize: 12,
                              fontWeight: isSelected ? FontWeight.bold : FontWeight.w500,
                              color: isSelected 
                                  ? AppColors.primary 
                                  : isAvailable ? AppColors.textBody : AppColors.textBody.withValues(alpha: 0.3),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              );
            }).toList(),
          ),
        ],
      ),
    );
  }

  Widget _buildFooter() {
    return Container(
      padding: EdgeInsets.fromLTRB(16, 12, 16, 12 + MediaQuery.of(context).padding.bottom),
      decoration: BoxDecoration(
        color: AppColors.surfaceColor,
        border: Border(top: BorderSide(color: AppColors.border)),
      ),
      child: Row(
        children: [
          Expanded(
            child: OutlinedButton(
              onPressed: () => context.pop(),
              style: OutlinedButton.styleFrom(
                side: BorderSide(color: AppColors.border),
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
                padding: const EdgeInsets.symmetric(vertical: 14),
              ),
              child: const Text('Cancel', style: TextStyle(color: AppColors.textHeading, fontWeight: FontWeight.bold)),
            ),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: BlocBuilder<CreateRouteLineBloc, CreateRouteLineState>(
              builder: (context, state) {
                return ElevatedButton(
                  onPressed: state is CreateRouteLineSubmitting ? null : _submit,
                  style: ElevatedButton.styleFrom(
                    backgroundColor: AppColors.primary,
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
                    padding: const EdgeInsets.symmetric(vertical: 14),
                  ),
                  child: state is CreateRouteLineSubmitting
                      ? const SizedBox(height: 20, width: 20, child: CircularProgressIndicator(strokeWidth: 2, color: Colors.white))
                      : Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Icon(widget.existingLine != null ? Icons.save : Icons.add, size: 18, color: Colors.white),
                            const SizedBox(width: 4),
                            Text(widget.existingLine != null ? 'Update Line' : 'Create Line', style: const TextStyle(color: Colors.white, fontWeight: FontWeight.bold)),
                          ],
                        ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
