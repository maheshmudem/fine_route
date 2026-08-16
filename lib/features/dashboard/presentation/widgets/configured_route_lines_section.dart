import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../config/theme/app_colors.dart';
import '../../../../core/widgets/app_loader.dart';
import '../../../../core/widgets/app_text.dart';
import '../../../../di/injection_container.dart';
import '../../../route_lines/domain/entities/route_line_entity.dart';
import '../../../route_lines/presentation/bloc/create_route_line/create_route_line_bloc.dart';
import '../../../route_lines/presentation/bloc/route_lines/route_lines_bloc.dart';
import '../../../route_lines/presentation/bloc/route_lines/route_lines_event.dart';
import '../../../route_lines/presentation/bloc/route_lines/route_lines_state.dart';
import '../../../route_lines/presentation/widgets/create_route_line_sheet.dart';

class ConfiguredRouteLinesSection extends StatelessWidget {
  const ConfiguredRouteLinesSection({super.key});

  void _showCreateLineSheet(BuildContext context, [RouteLineEntity? existingLine]) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (_) => BlocProvider(
        create: (context) => getIt<CreateRouteLineBloc>(),
        child: CreateRouteLineSheet(existingLine: existingLine),
      ),
    ).then((result) {
      if (result == true && context.mounted) {
        context.read<RouteLinesBloc>().add(LoadRouteLinesEvent());
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => getIt<RouteLinesBloc>()..add(LoadRouteLinesEvent()),
      child: BlocBuilder<RouteLinesBloc, RouteLinesState>(
        buildWhen: (previous, current) => current is! RouteLineActionLoading && current is! RouteLineActionSuccess,
        builder: (context, state) {
          int linesCount = 0;
          if (state is RouteLinesLoaded) {
            linesCount = state.lines.length;
          }

          return Container(
            decoration: BoxDecoration(
              color: AppColors.surfaceColor,
              borderRadius: BorderRadius.circular(12),
              border: Border.all(color: AppColors.border),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Container(
                            padding: const EdgeInsets.all(8),
                            decoration: BoxDecoration(
                              color: AppColors.scaffoldBackground,
                              borderRadius: BorderRadius.circular(8),
                            ),
                            child: const Icon(Icons.calendar_today, size: 20, color: AppColors.primary),
                          ),
                          const SizedBox(width: 12),
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                const AppText.titleMedium(
                                  'Current Week Activity & Configured Route Lines',
                                  fontWeight: FontWeight.bold,
                                  color: AppColors.textHeading,
                                ),
                                const SizedBox(height: 8),
                                Container(
                                  padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                                  decoration: BoxDecoration(
                                    color: linesCount > 0 ? Colors.green : AppColors.border,
                                    borderRadius: BorderRadius.circular(12),
                                  ),
                                  child: AppText.labelSmall(
                                    '$linesCount Lines Configured',
                                    color: linesCount > 0 ? Colors.white : AppColors.textBody,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 12),
                      AppText.bodySmall(
                        'Configure your collection route name, area/location details, and assigned day time slot sessions.',
                        color: AppColors.textBody.withValues(alpha: 0.8),
                      ),
                      const SizedBox(height: 16),
                      SizedBox(
                        width: double.infinity,
                        child: OutlinedButton.icon(
                          onPressed: () => _showCreateLineSheet(context),
                          icon: const Icon(Icons.add, size: 16, color: AppColors.primary),
                          label: const AppText.labelMedium('Manage / Add Collection Line', color: AppColors.primary),
                          style: OutlinedButton.styleFrom(
                            side: BorderSide(color: AppColors.primary.withValues(alpha: 0.3)),
                            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
                            padding: const EdgeInsets.symmetric(vertical: 12),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                if (state is RouteLinesLoading)
                  const Padding(
                    padding: EdgeInsets.all(32),
                    child: Center(child: AppLoader()),
                  )
                else if (state is RouteLinesError)
                  Padding(
                    padding: const EdgeInsets.all(16),
                    child: Center(child: AppText.bodyMedium(state.message, color: AppColors.error)),
                  )
                else if (state is RouteLinesLoaded && state.lines.isEmpty)
                  Padding(
                    padding: const EdgeInsets.fromLTRB(16, 0, 16, 16),
                    child: CustomPaint(
                      painter: _DashedBorderPainter(color: AppColors.border, radius: 8),
                      child: Container(
                        width: double.infinity,
                        padding: const EdgeInsets.symmetric(vertical: 24),
                        decoration: BoxDecoration(
                          color: AppColors.surfaceColor,
                          borderRadius: BorderRadius.circular(8),
                        ),
                        child: Column(
                          children: [
                            const AppText.bodyMedium(
                              'No collection route lines configured yet.',
                              color: AppColors.textBody,
                            ),
                            const SizedBox(height: 12),
                            OutlinedButton.icon(
                              onPressed: () => _showCreateLineSheet(context),
                              icon: const Icon(Icons.add, size: 16, color: AppColors.primary),
                              label: const AppText.labelMedium('Create Your First Route Line', color: AppColors.primary),
                              style: OutlinedButton.styleFrom(
                                side: BorderSide(color: AppColors.primary.withValues(alpha: 0.3)),
                                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
                                padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  )
                else if (state is RouteLinesLoaded && state.lines.isNotEmpty)
                  Padding(
                    padding: const EdgeInsets.fromLTRB(16, 0, 16, 16),
                    child: Column(
                      children: state.lines.map((line) => _buildRouteLineCard(context, line)).toList(),
                    ),
                  ),
              ],
            ),
          );
        },
      ),
    );
  }

  Widget _buildRouteLineCard(BuildContext context, RouteLineEntity line) {
    return Container(
      margin: const EdgeInsets.only(bottom: 12),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: AppColors.scaffoldBackground,
        border: Border.all(color: AppColors.border),
        borderRadius: BorderRadius.circular(12),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Expanded(
                child: AppText.titleMedium(line.name, fontWeight: FontWeight.bold, color: AppColors.textHeading),
              ),
              Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  IconButton(
                    icon: const Icon(Icons.edit_outlined, size: 20, color: AppColors.primary),
                    padding: EdgeInsets.zero,
                    constraints: const BoxConstraints(),
                    onPressed: () {
                      _showCreateLineSheet(context, line);
                    },
                  ),
                  const SizedBox(width: 16),
                  IconButton(
                    icon: const Icon(Icons.delete_outline, size: 20, color: AppColors.error),
                    padding: EdgeInsets.zero,
                    constraints: const BoxConstraints(),
                    onPressed: () {
                      context.read<RouteLinesBloc>().add(DeleteRouteLineEvent(line.publicId));
                    },
                  ),
                ],
              )
            ],
          ),
          if (line.area.isNotEmpty) ...[
            const SizedBox(height: 4),
            Row(
              children: [
                const Icon(Icons.location_on_outlined, size: 14, color: AppColors.textBody),
                const SizedBox(width: 4),
                AppText.bodySmall(line.area, color: AppColors.textBody),
              ],
            ),
          ],
          const SizedBox(height: 12),
          const Divider(height: 1),
          const SizedBox(height: 12),
          Wrap(
            spacing: 8,
            runSpacing: 8,
            children: line.daySchedules.map((schedule) {
              final day = schedule.dayOfWeek.substring(0, 3).toUpperCase();
              final isMorning = schedule.portion == 'morning' || schedule.portion == 'both';
              final isAfternoon = schedule.portion == 'afternoon' || schedule.portion == 'both';
              
              return Container(
                padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                decoration: BoxDecoration(
                  color: AppColors.surfaceColor,
                  border: Border.all(color: AppColors.border),
                  borderRadius: BorderRadius.circular(16),
                ),
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Text(day, style: const TextStyle(fontSize: 10, fontWeight: FontWeight.bold, color: AppColors.textHeading)),
                    const SizedBox(width: 6),
                    Icon(
                      Icons.wb_sunny, 
                      size: 12, 
                      color: isMorning ? Colors.orange : AppColors.border,
                    ),
                    const SizedBox(width: 2),
                    Icon(
                      Icons.nights_stay, 
                      size: 12, 
                      color: isAfternoon ? AppColors.primary : AppColors.border,
                    ),
                  ],
                ),
              );
            }).toList(),
          ),
        ],
      ),
    );
  }
}

class _DashedBorderPainter extends CustomPainter {
  final Color color;
  final double radius;

  _DashedBorderPainter({required this.color, required this.radius});

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = color
      ..strokeWidth = 1
      ..style = PaintingStyle.stroke;

    final path = Path()
      ..addRRect(RRect.fromRectAndRadius(
        Rect.fromLTWH(0, 0, size.width, size.height),
        Radius.circular(radius),
      ));

    final dashedPath = Path();
    for (PathMetric measurePath in path.computeMetrics()) {
      double distance = 0.0;
      bool draw = true;
      while (distance < measurePath.length) {
        final double length = draw ? 6.0 : 4.0;
        if (draw) {
          dashedPath.addPath(
            measurePath.extractPath(distance, distance + length),
            Offset.zero,
          );
        }
        distance += length;
        draw = !draw;
      }
    }
    canvas.drawPath(dashedPath, paint);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}
