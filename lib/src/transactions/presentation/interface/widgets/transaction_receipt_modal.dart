import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import '../../../../../shared/presentation/theme/app_colors.dart';
import '../../../../../shared/presentation/widgets/constants/app_text.dart';
import '../../../../../shared/presentation/widgets/snackbar.dart';
import '../../../../dashboard/domain/entities/activity.dart';

/// Modal showing transaction receipt details
class TransactionReceiptModal extends StatefulWidget {
  final Activity activity;

  const TransactionReceiptModal({
    super.key,
    required this.activity,
  });

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
                    'Transaction Receipt',
                    color: AppColors.primaryText(context),
                  ),
                  IconButton(
                    icon: const Icon(Icons.close),
                    onPressed: () => Navigator.pop(context),
                  ),
                ],
              ),
              const SizedBox(height: 24),

              // Transaction details
              _buildDetailRow('Type', _getTypeLabel(widget.activity.type)),
              _buildDetailRow('Asset Class', _getAssetClass()),
              if (widget.activity.shares != null)
                _buildDetailRow('Quantity', widget.activity.shares!),
              _buildDetailRow('Purchase Price',
                  'GHS ${_getPurchasePrice().toStringAsFixed(2)}'),
              _buildDetailRow(
                  'Total Cost', 'GHS ${widget.activity.amount.toStringAsFixed(2)}'),
              _buildDetailRow('Charges', 'GHS ${_getCharges().toStringAsFixed(2)}'),
              _buildDetailRow('Date', _formatDate(widget.activity.timestamp)),
              _buildStatusRow(),
              _buildDetailRow('Executed by', widget.activity.subtitle),
              _buildDetailRow('ID', _getTransactionId()),

              const SizedBox(height: 24),

              // Add notes field
              TextField(
                controller: _notesController,
                decoration: InputDecoration(
                  hintText: 'Add notes',
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
                maxLines: 3,
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
                        child: const AppText(
                          'Done',
                          style: TextStyle(
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
                      icon: const Icon(Icons.share),
                      onPressed: () {
                        // TODO: Implement share functionality
                        SnackBarHelper.showInfoSnackBar(
                          context,
                          'Share coming soon',
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

  Widget _buildDetailRow(String label, String value) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 16),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          AppText.small(
            label,
            color: AppColors.secondaryText(context),
          ),
          AppText.small(
            value,
            color: AppColors.primaryText(context),
          ),
        ],
      ),
    );
  }

  Widget _buildStatusRow() {
    return Padding(
      padding: const EdgeInsets.only(bottom: 16),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          AppText.small(
            'Status',
            color: AppColors.secondaryText(context),
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
        label = 'Completed';
        backgroundColor = const Color(0xFFE8F5E9);
        textColor = const Color(0xFF4CAF50);
        break;
      case ActivityStatus.pending:
        label = 'Pending';
        backgroundColor = const Color(0xFFF3E5F5);
        textColor = const Color(0xFF9C27B0);
        break;
      case ActivityStatus.failed:
        label = 'Failed';
        backgroundColor = const Color(0xFFFFEBEE);
        textColor = const Color(0xFFEF5350);
        break;
    }

    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
      decoration: BoxDecoration(
        color: backgroundColor,
        borderRadius: BorderRadius.circular(20),
      ),
      child: AppText.smallest(
        label,
        color: textColor,
      ),
    );
  }

  String _getTypeLabel(ActivityType type) {
    switch (type) {
      case ActivityType.buy:
        return 'Buy';
      case ActivityType.sell:
        return 'Sell';
      case ActivityType.deposit:
        return 'Deposit';
      case ActivityType.withdrawal:
        return 'Withdrawal';
    }
  }

  String _getAssetClass() {
    // Extract asset class from title or use title directly
    return widget.activity.title;
  }

  double _getPurchasePrice() {
    if (widget.activity.shares != null) {
      final shares = double.tryParse(
              widget.activity.shares!.split(' ')[0].replaceAll(',', '')) ??
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
