import 'package:confetti/confetti.dart';
import 'package:flutter/material.dart';

import '../../utils/extension.dart';
import '../theme/app_colors.dart';
import 'app_button.dart';
import 'constants/app_spacer.dart';
import 'constants/app_text.dart';

/// A reusable success screen with confetti animation
class ConfettiSuccessScreen extends StatefulWidget {
  /// The title text to display
  final String title;

  /// The description text to display
  final String description;

  /// The primary button text
  final String primaryButtonText;

  /// Callback when primary button is tapped
  final VoidCallback onPrimaryButtonTap;

  /// Optional secondary button text (e.g., "Skip")
  final String? secondaryButtonText;

  /// Optional callback when secondary button is tapped
  final VoidCallback? onSecondaryButtonTap;

  /// Optional custom icon widget (defaults to party popper emoji)
  final Widget? icon;

  const ConfettiSuccessScreen({
    super.key,
    required this.title,
    required this.description,
    required this.primaryButtonText,
    required this.onPrimaryButtonTap,
    this.secondaryButtonText,
    this.onSecondaryButtonTap,
    this.icon,
  });

  @override
  State<ConfettiSuccessScreen> createState() => _ConfettiSuccessScreenState();
}

class _ConfettiSuccessScreenState extends State<ConfettiSuccessScreen> {
  late ConfettiController _confettiController;

  @override
  void initState() {
    super.initState();
    _confettiController = ConfettiController(
      duration: const Duration(seconds: 3),
    );
    // Start confetti animation after a short delay
    Future.delayed(const Duration(milliseconds: 300), () {
      if (mounted) {
        _confettiController.play();
      }
    });
  }

  @override
  void dispose() {
    _confettiController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Stack(
          children: [
            // Main content
            Padding(
              padding: context.responsivePadding(
                mobile: const EdgeInsets.all(24.0),
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Spacer(),
                  // Confetti dots at the top
                  _buildConfettiDots(),
                  const AppSpacer.vLarge(),
                  // Icon/Emoji
                  widget.icon ?? _buildDefaultIcon(),
                  const AppSpacer.vLarge(),
                  // Title
                  AppText.large(
                    widget.title,
                    align: TextAlign.center,
                    style: const TextStyle(fontWeight: FontWeight.w400),
                  ),
                  const AppSpacer.vShort(),
                  // Description
                  AppText.smaller(
                    widget.description,
                    align: TextAlign.center,
                    color: AppColors.secondaryText(context),
                  ),
                  const Spacer(),
                  // Primary Button
                  AppButton(
                    text: widget.primaryButtonText,
                    backgroundColor: AppColors.appPrimary,
                    textColor: Colors.white,
                    borderRadius: 12,
                    padding: EdgeInsets.zero,
                    onTap: widget.onPrimaryButtonTap,
                  ),
                  // Secondary Button (optional)
                  if (widget.secondaryButtonText != null) ...[
                    const AppSpacer.vShort(),
                    AppButton(
                      text: widget.secondaryButtonText!,
                      backgroundColor: AppColors.offWhite(context),
                      borderRadius: 12,
                      padding: EdgeInsets.zero,
                      onTap: widget.onSecondaryButtonTap,
                      borderColor: AppColors.grey(
                        context,
                      ).withValues(alpha: 0.2),
                    ),
                  ],
                  const AppSpacer.vLarge(),
                ],
              ),
            ),
            // Confetti animation
            Align(
              alignment: Alignment.topCenter,
              child: ConfettiWidget(
                confettiController: _confettiController,
                blastDirection: 3.14 / 2, // Down
                emissionFrequency: 0.05,
                numberOfParticles: 20,
                gravity: 0.3,
                shouldLoop: false,
                colors: const [
                  Color(0xFFFF6B6B),
                  Color(0xFF4ECDC4),
                  Color(0xFFFFE66D),
                  Color(0xFF95E1D3),
                  Color(0xFFA8E6CF),
                  Color(0xFFFFD93D),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildDefaultIcon() {
    return Text(
      '🎉',
      style: TextStyle(fontSize: context.responsiveFontSize(mobile: 100)),
    );
  }

  Widget _buildConfettiDots() {
    return SizedBox(
      height: 120,
      child: Stack(
        children: [
          // Colored dots scattered around
          ..._generateConfettiDots(),
          // Streamers
          ..._generateStreamers(),
        ],
      ),
    );
  }

  List<Widget> _generateConfettiDots() {
    final colors = [
      const Color(0xFFFF6B6B),
      const Color(0xFF4ECDC4),
      const Color(0xFFFFE66D),
      const Color(0xFF95E1D3),
      const Color(0xFFA8E6CF),
      const Color(0xFFFFD93D),
      const Color(0xFFB39DDB),
    ];

    final positions = [
      const Offset(30, 20),
      const Offset(80, 10),
      const Offset(120, 30),
      const Offset(40, 60),
      const Offset(90, 80),
      const Offset(140, 70),
      const Offset(180, 25),
      const Offset(200, 55),
      const Offset(240, 15),
      const Offset(270, 45),
      const Offset(50, 100),
      const Offset(160, 95),
      const Offset(220, 85),
    ];

    return List.generate(positions.length, (index) {
      final position = positions[index];
      final color = colors[index % colors.length];
      final isCircle = index % 2 == 0;

      return Positioned(
        left: position.dx,
        top: position.dy,
        child: Container(
          width: isCircle ? 8 : 6,
          height: isCircle ? 8 : 6,
          decoration: BoxDecoration(
            color: color,
            shape: isCircle ? BoxShape.circle : BoxShape.rectangle,
          ),
        ),
      );
    });
  }

  List<Widget> _generateStreamers() {
    return [
      Positioned(
        left: 60,
        top: 15,
        child: CustomPaint(
          size: const Size(30, 40),
          painter: StreamerPainter(const Color(0xFFFFE66D)),
        ),
      ),
      Positioned(
        right: 60,
        top: 15,
        child: CustomPaint(
          size: const Size(30, 40),
          painter: StreamerPainter(const Color(0xFF4ECDC4)),
        ),
      ),
    ];
  }
}

class StreamerPainter extends CustomPainter {
  final Color color;

  StreamerPainter(this.color);

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = color
      ..style = PaintingStyle.stroke
      ..strokeWidth = 3
      ..strokeCap = StrokeCap.round;

    final path = Path();
    path.moveTo(size.width / 2, 0);
    path.quadraticBezierTo(
      size.width * 0.25,
      size.height * 0.3,
      size.width * 0.5,
      size.height * 0.5,
    );
    path.quadraticBezierTo(
      size.width * 0.75,
      size.height * 0.7,
      size.width * 0.4,
      size.height,
    );

    canvas.drawPath(path, paint);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}
