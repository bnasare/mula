import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import '../../../../../shared/presentation/theme/app_colors.dart';
import '../../../../../shared/presentation/widgets/constants/app_text.dart';
import '../../../../../shared/presentation/widgets/snackbar.dart';
import '../../../../../shared/utils/localization_extension.dart';
import '../../../../dashboard/domain/entities/activity.dart';

/// Modal showing transaction receipt details
class TransactionReceiptModal extends StatefulWidget {
  final Activity activity;

  const TransactionReceiptModal({super.key, required this.activity});

  @override
  State<TransactionReceiptModal> createState() =>
      _TransactionReceiptModalState();
}

class _TransactionReceiptModalState extends State<TransactionReceiptModal> {
  final TextEditingController _notesController = TextEditingController();

  @override
  void dispose() {
    _notesController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      child: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(24.0),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              // Green icon at top
              Container(
                width: 56,
                height: 56,
                decoration: BoxDecoration(
                  color: AppColors.appPrimary.withOpacity(0.1),
                  shape: BoxShape.circle,
                ),
                child: Icon(
                  Icons.receipt_long,
                  color: AppColors.appPrimary,
                  size: 28,
                ),
              ),
              const SizedBox(height: 24),

              // Header with title and close button
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  AppText.large(
                    context.localize.transactionReceipt,
                    style: TextStyle(
                      fontWeight: FontWeight.w500,
                      color: AppColors.primaryText(context),
                      fontSize: 22,
                    ),
                  ),
                  IconButton.filled(
                    style: IconButton.styleFrom(
                      backgroundColor: AppColors.grey(
                        context,
                      ).withValues(alpha: 0.1),
                      foregroundColor: AppColors.primaryText(context),
                      padding: EdgeInsets.zero,
                      minimumSize: const Size(38, 38),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8),
                      ),
                    ),
                    icon: const Icon(Icons.close),
                    onPressed: () => Navigator.pop(context),
                  ),
                ],
              ),
              const SizedBox(height: 24),

              // Transaction details
              _buildDetailRow(
                context.localize.type,
                _getTypeLabel(widget.activity.type),
                true,
              ),
              _buildDetailRow(
                context.localize.assetClass,
                _getAssetClass(),
                false,
              ),
              if (widget.activity.shares != null)
                _buildDetailRow(
                  context.localize.quantity,
                  widget.activity.shares!,
                  true,
                ),
              _buildDetailRow(
                context.localize.purchasePrice,
                'GHS ${_getPurchasePrice().toStringAsFixed(2)}',
                widget.activity.shares != null ? false : true,
              ),
              _buildDetailRow(
                context.localize.totalCost,
                'GHS ${widget.activity.amount.toStringAsFixed(2)}',
                widget.activity.shares != null ? true : false,
              ),
              _buildDetailRow(
                context.localize.charges,
                'GHS ${_getCharges().toStringAsFixed(2)}',
                widget.activity.shares != null ? false : true,
              ),
              _buildDetailRow(
                context.localize.date,
                _formatDate(widget.activity.timestamp),
                widget.activity.shares != null ? true : false,
              ),
              _buildStatusRow(widget.activity.shares != null ? false : true),
              _buildDetailRow(
                context.localize.executedBy,
                widget.activity.subtitle,
                widget.activity.shares != null ? true : false,
              ),
              _buildDetailRow(
                context.localize.id,
                _getTransactionId(),
                widget.activity.shares != null ? false : true,
              ),

              // Add notes field
              TextField(
                controller: _notesController,
                decoration: InputDecoration(
                  hintText: context.localize.addNotes,
                  hintStyle: TextStyle(
                    color: AppColors.secondaryText(context),
                    fontSize: 14,
                  ),
                  filled: true,
                  fillColor: AppColors.offWhite(context),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(8),
                    borderSide: BorderSide.none,
                  ),
                ),
                maxLines: 1,
              ),
              const SizedBox(height: 24),

              // Action buttons
              Row(
                children: [
                  Expanded(
                    child: SizedBox(
                      height: 50,
                      child: ElevatedButton(
                        onPressed: () => Navigator.pop(context),
                        style: ElevatedButton.styleFrom(
                          backgroundColor: AppColors.appPrimary,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(8),
                          ),
                        ),
                        child: AppText(
                          context.localize.done,
                          style: const TextStyle(
                            color: Colors.white,
                            fontSize: 16,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(width: 12),
                  Container(
                    height: 50,
                    width: 50,
                    decoration: BoxDecoration(
                      border: Border.all(color: AppColors.border(context)),
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: IconButton(
                      icon: const Icon(Icons.share_outlined),
                      onPressed: () {
                        // TODO: Implement share functionality
                        SnackBarHelper.showInfoSnackBar(
                          context,
                          context.localize.shareComingSoon,
                        );
                      },
                    ),
                  ),
                ],
              ),
              SizedBox(height: MediaQuery.of(context).viewInsets.bottom + 16),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildDetailRow(
    String label,
    String value, [
    bool hasBackground = false,
  ]) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      margin: const EdgeInsets.only(bottom: 4),
      decoration: BoxDecoration(
        color: hasBackground ? AppColors.offWhite(context) : Colors.transparent,
        borderRadius: BorderRadius.circular(8),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          AppText.small(
            label,
            style: TextStyle(
              color: AppColors.secondaryText(context),
              fontSize: 12,
            ),
          ),
          AppText.small(
            value,
            style: TextStyle(
              color: AppColors.primaryText(context),
              fontSize: 12,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildStatusRow([bool hasBackground = false]) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      margin: const EdgeInsets.only(bottom: 4),
      decoration: BoxDecoration(
        color: hasBackground ? AppColors.offWhite(context) : Colors.transparent,
        borderRadius: BorderRadius.circular(8),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          AppText.small(
            context.localize.status,
            style: TextStyle(
              color: AppColors.secondaryText(context),
              fontSize: 12,
            ),
          ),
          _buildStatusBadge(),
        ],
      ),
    );
  }

  Widget _buildStatusBadge() {
    final String label;
    final Color backgroundColor;
    final Color textColor;

    switch (widget.activity.status) {
      case ActivityStatus.completed:
        label = context.localize.completed;
        backgroundColor = const Color(0xFFE8F5E9);
        textColor = const Color(0xFF4CAF50);
        break;
      case ActivityStatus.pending:
        label = context.localize.pending;
        backgroundColor = const Color(0xFFF3E5F5);
        textColor = const Color(0xFF9C27B0);
        break;
      case ActivityStatus.failed:
        label = context.localize.failed;
        backgroundColor = const Color(0xFFFFEBEE);
        textColor = const Color(0xFFEF5350);
        break;
    }

    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
      decoration: BoxDecoration(
        color: backgroundColor,
        borderRadius: BorderRadius.circular(20),
        border: Border.all(color: textColor, width: 0.3),
      ),
      child: AppText.smallest(label, color: textColor),
    );
  }

  String _getTypeLabel(ActivityType type) {
    switch (type) {
      case ActivityType.buy:
        return context.localize.buy;
      case ActivityType.sell:
        return context.localize.sell;
      case ActivityType.deposit:
        return context.localize.deposit;
      case ActivityType.withdrawal:
        return context.localize.withdrawal;
    }
  }

  String _getAssetClass() {
    // Extract asset class from title or use title directly
    return widget.activity.title;
  }

  double _getPurchasePrice() {
    if (widget.activity.shares != null) {
      final shares =
          double.tryParse(
            widget.activity.shares!.split(' ')[0].replaceAll(',', ''),
          ) ??
          1;
      return widget.activity.amount / shares;
    }
    return widget.activity.amount;
  }

  double _getCharges() {
    // Calculate charges (example: 1% of total)
    return widget.activity.amount * 0.01;
  }

  String _formatDate(DateTime timestamp) {
    return DateFormat('d\'th\' MMMM y').format(timestamp);
  }

  String _getTransactionId() {
    // Generate a transaction ID based on timestamp
    return 'TRX-${widget.activity.timestamp.millisecondsSinceEpoch.toString().substring(6)}';
  }
}
