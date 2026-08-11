import 'package:equatable/equatable.dart';

class RecentCollection extends Equatable {
  final String publicId;
  final String receiptNumber;
  final String customerCode;
  final String customerName;
  final String customerPublicId;
  final String linePublicId;
  final String lineName;
  final String portion;
  final String disbursedDate;
  final String customerStartDate;
  final int totalInstallments;
  final int installmentsPaidCount;
  final int remainingInstallmentsCount;
  final double outstandingBalance;
  final int skippedInstallmentsCount;
  final String collectionDate;
  final double expectedAmount;
  final double collectedAmount;
  final int status;
  final String statusCode;
  final String statusName;
  final int paymentMode;
  final String paymentModeName;
  final String remarks;
  final bool isCollectedToday;
  final bool isEdited;
  final int editCount;
  final DateTime createdAt;

  const RecentCollection({
    required this.publicId,
    required this.receiptNumber,
    required this.customerCode,
    required this.customerName,
    required this.customerPublicId,
    required this.linePublicId,
    required this.lineName,
    required this.portion,
    required this.disbursedDate,
    required this.customerStartDate,
    required this.totalInstallments,
    required this.installmentsPaidCount,
    required this.remainingInstallmentsCount,
    required this.outstandingBalance,
    required this.skippedInstallmentsCount,
    required this.collectionDate,
    required this.expectedAmount,
    required this.collectedAmount,
    required this.status,
    required this.statusCode,
    required this.statusName,
    required this.paymentMode,
    required this.paymentModeName,
    required this.remarks,
    required this.isCollectedToday,
    required this.isEdited,
    required this.editCount,
    required this.createdAt,
  });

  @override
  List<Object?> get props => [
        publicId,
        receiptNumber,
        customerCode,
        customerName,
        customerPublicId,
        linePublicId,
        lineName,
        portion,
        disbursedDate,
        customerStartDate,
        totalInstallments,
        installmentsPaidCount,
        remainingInstallmentsCount,
        outstandingBalance,
        skippedInstallmentsCount,
        collectionDate,
        expectedAmount,
        collectedAmount,
        status,
        statusCode,
        statusName,
        paymentMode,
        paymentModeName,
        remarks,
        isCollectedToday,
        isEdited,
        editCount,
        createdAt,
      ];
}
