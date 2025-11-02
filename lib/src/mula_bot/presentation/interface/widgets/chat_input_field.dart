import 'package:flutter/material.dart';

import '../../../../../shared/presentation/theme/app_colors.dart';

/// Chat input field with send button
class ChatInputField extends StatefulWidget {
  final Function(String) onSend;
  final bool enabled;

  const ChatInputField({
    super.key,
    required this.onSend,
    this.enabled = true,
  });

  @override
  State<ChatInputField> createState() => _ChatInputFieldState();
}

class _ChatInputFieldState extends State<ChatInputField> {
  final TextEditingController _controller = TextEditingController();
  bool _hasText = false;

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  void _handleSend() {
    final text = _controller.text.trim();
    if (text.isNotEmpty && widget.enabled) {
      widget.onSend(text);
      _controller.clear();
      setState(() => _hasText = false);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
      decoration: BoxDecoration(
        color: Colors.white,
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            blurRadius: 8,
            offset: const Offset(0, -2),
          ),
        ],
      ),
      child: SafeArea(
        top: false,
        child: Row(
          children: [
            // Attachment button (optional, can be added later)
            IconButton(
              icon: Icon(
                Icons.add_circle_outline,
                color: AppColors.secondaryText(context),
              ),
              onPressed: widget.enabled
                  ? () {
                      // TODO: Add attachment functionality
                    }
                  : null,
            ),
            const SizedBox(width: 8),

            // Text input field
            Expanded(
              child: TextField(
                controller: _controller,
                enabled: widget.enabled,
                maxLines: null,
                textCapitalization: TextCapitalization.sentences,
                decoration: InputDecoration(
                  hintText: 'Type your message here',
                  hintStyle: TextStyle(
                    color: AppColors.secondaryText(context),
                    fontSize: 14,
                  ),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(24),
                    borderSide: BorderSide(
                      color: AppColors.border(context),
                    ),
                  ),
                  enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(24),
                    borderSide: BorderSide(
                      color: AppColors.border(context),
                    ),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(24),
                    borderSide: BorderSide(
                      color: AppColors.appPrimary,
                      width: 1.5,
                    ),
                  ),
                  contentPadding: const EdgeInsets.symmetric(
                    horizontal: 16,
                    vertical: 12,
                  ),
                  filled: true,
                  fillColor: AppColors.offWhite(context),
                ),
                onChanged: (value) {
                  setState(() {
                    _hasText = value.trim().isNotEmpty;
                  });
                },
                onSubmitted: (_) => _handleSend(),
              ),
            ),
            const SizedBox(width: 8),

            // Send button
            Container(
              width: 40,
              height: 40,
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                  colors: _hasText && widget.enabled
                      ? [
                          const Color(0xFF4CAF50),
                          const Color(0xFF2E7D32),
                        ]
                      : [
                          AppColors.lightGrey(context),
                          AppColors.lightGrey(context),
                        ],
                ),
                shape: BoxShape.circle,
              ),
              child: IconButton(
                icon: const Icon(Icons.send, size: 20),
                color: Colors.white,
                onPressed: _hasText && widget.enabled ? _handleSend : null,
                padding: EdgeInsets.zero,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
