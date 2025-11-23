import 'package:flutter/material.dart';
import 'package:iconly/iconly.dart';
import 'package:intl/intl.dart';

import '../../../../../shared/presentation/theme/app_colors.dart';
import '../../../../../shared/presentation/widgets/constants/app_text.dart';

/// Cash wallet section with balance display and card visual
class CashWalletSection extends StatefulWidget {
  final double balance;
  final String userName;
  final VoidCallback? onTap;

  const CashWalletSection({
    super.key,
    required this.balance,
    required this.userName,
    this.onTap,
  });

  @override
  State<CashWalletSection> createState() => _CashWalletSectionState();
}

class _CashWalletSectionState extends State<CashWalletSection> {
  bool _isBalanceVisible = true;

  @override
  Widget build(BuildContext context) {
    final currencyFormat = NumberFormat.currency(
      symbol: 'GHS ',
      decimalDigits: 2,
    );

    return GestureDetector(
      onTap: widget.onTap,
      child: Container(
        padding: const EdgeInsets.all(8),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(12),
          border: Border.all(color: AppColors.border(context), width: 0.5),
        ),
        child: Row(
          children: [
            // Left side: Cash balance info
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Icon and label row
                  Row(
                    children: [
                      Container(
                        width: 40,
                        height: 40,
                        decoration: BoxDecoration(
                          color: AppColors.offWhite(context),
                          borderRadius: BorderRadius.circular(20),
                        ),
                        child: const Icon(IconlyLight.wallet, size: 20),
                      ),
                      const SizedBox(width: 12),
                      AppText.small(
                        'Cash Balance',
                        color: AppColors.secondaryText(context),
                      ),
                    ],
                  ),
                  const SizedBox(height: 8),
                  // Balance value
                  AppText.large(
                    _isBalanceVisible
                        ? currencyFormat.format(widget.balance)
                        : '••••••',
                    color: AppColors.primaryText(context),
                  ),
                ],
              ),
            ),
            const SizedBox(width: 12),

            // Right side: Purple gradient card
            Container(
              width: 150,
              height: 100,
              decoration: BoxDecoration(
                gradient: const LinearGradient(
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                  colors: [
                    Color(0xFF7B68EE), // Medium slate blue
                    Color(0xFF6A5ACD), // Slate blue
                  ],
                ),
                borderRadius: BorderRadius.circular(12),
              ),
              child: Padding(
                padding: const EdgeInsets.all(12),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    // Balance label with eye icon
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        AppText.smallest(
                          'Balance',
                          style: const TextStyle(
                            color: Colors.white,
                            fontSize: 12,
                          ),
                        ),
                        GestureDetector(
                          onTap: () {
                            setState(() {
                              _isBalanceVisible = !_isBalanceVisible;
                            });
                          },
                          child: Icon(
                            _isBalanceVisible ? IconlyLight.show : IconlyLight.hide,
                            size: 16,
                            color: Colors.white,
                          ),
                        ),
                      ],
                    ),

                    // User name
                    AppText.medium(
                      widget.userName,
                      style: const TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
