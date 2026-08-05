import 'package:flutter/material.dart';

class StatusBadge extends StatelessWidget {
  final String label;
  final Color backgroundColor;
  final Color textColor;
  final double fontSize;
  final EdgeInsetsGeometry? padding;

  const StatusBadge({
    super.key,
    required this.label,
    required this.backgroundColor,
    this.textColor = Colors.white,
    this.fontSize = 11,
    this.padding,
  });

  factory StatusBadge.scheduled() => const StatusBadge(
        label: 'Scheduled',
        backgroundColor: Color(0xFF1976D2),
      );

  factory StatusBadge.completed() => const StatusBadge(
        label: 'Completed',
        backgroundColor: Color(0xFF388E3C),
      );

  factory StatusBadge.cancelled() => const StatusBadge(
        label: 'Cancelled',
        backgroundColor: Color(0xFFD32F2F),
      );

  factory StatusBadge.pending() => const StatusBadge(
        label: 'Pending',
        backgroundColor: Color(0xFFF57C00),
      );

  factory StatusBadge.active() => const StatusBadge(
        label: 'Active',
        backgroundColor: Color(0xFF388E3C),
      );

  factory StatusBadge.expired() => const StatusBadge(
        label: 'Expired',
        backgroundColor: Color(0xFF9E9E9E),
      );

  factory StatusBadge.paid() => const StatusBadge(
        label: 'Paid',
        backgroundColor: Color(0xFF388E3C),
      );

  factory StatusBadge.overdue() => const StatusBadge(
        label: 'Overdue',
        backgroundColor: Color(0xFFD32F2F),
      );

  factory StatusBadge.processing() => const StatusBadge(
        label: 'Processing',
        backgroundColor: Color(0xFF7B1FA2),
      );

  factory StatusBadge.sampleCollected() => const StatusBadge(
        label: 'Sample Collected',
        backgroundColor: Color(0xFF1976D2),
      );

  factory StatusBadge.custom({
    required String label,
    required Color backgroundColor,
    Color textColor = Colors.white,
  }) =>
      StatusBadge(
        label: label,
        backgroundColor: backgroundColor,
        textColor: textColor,
      );

  @override
  Widget build(BuildContext context) {
    return Container(
      padding:
          padding ?? const EdgeInsets.symmetric(horizontal: 8, vertical: 3),
      decoration: BoxDecoration(
        color: backgroundColor,
        borderRadius: BorderRadius.circular(4),
      ),
      child: Text(
        label,
        style: TextStyle(
          color: textColor,
          fontSize: fontSize,
          fontWeight: FontWeight.w600,
        ),
      ),
    );
  }
}
