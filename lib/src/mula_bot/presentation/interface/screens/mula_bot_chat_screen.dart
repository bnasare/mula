import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../../../injection_container.dart';
import '../../../../../shared/data/image_assets.dart';
import '../../../../../shared/presentation/theme/app_colors.dart';
import '../../../../../shared/presentation/widgets/constants/app_text.dart';
import '../../../../../shared/presentation/widgets/mula_app_bar.dart';
import '../../../../../shared/utils/localization_extension.dart';
import '../../provider/mula_bot_provider.dart';
import '../widgets/chat_input_field.dart';
import '../widgets/chat_message_bubble.dart';
import '../widgets/suggested_prompt_chip.dart';

/// Main chat screen for Mula Bot
class MulaBotChatScreen extends StatelessWidget {
  const MulaBotChatScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => sl<MulaBotProvider>(),
      child: const _MulaBotChatView(),
    );
  }
}

class _MulaBotChatView extends StatefulWidget {
  const _MulaBotChatView();

  @override
  State<_MulaBotChatView> createState() => _MulaBotChatViewState();
}

class _MulaBotChatViewState extends State<_MulaBotChatView> {
  final ScrollController _scrollController = ScrollController();

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  void _scrollToBottom() {
    if (_scrollController.hasClients) {
      Future.delayed(const Duration(milliseconds: 100), () {
        if (mounted && _scrollController.hasClients) {
          _scrollController.animateTo(
            _scrollController.position.maxScrollExtent,
            duration: const Duration(milliseconds: 300),
            curve: Curves.easeOut,
          );
        }
      });
    }
  }

  void _handleSendMessage(String text, MulaBotProvider provider) {
    provider.sendMessage(text, userName: 'Phil');
    _scrollToBottom();
  }

  void _handlePromptTap(String prompt, MulaBotProvider provider) {
    _handleSendMessage(prompt, provider);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: MulaAppBar(title: 'Mula', showBottomDivider: true),
      body: Consumer<MulaBotProvider>(
        builder: (context, provider, _) {
          return Column(
            children: [
              // Messages area
              Expanded(
                child: provider.messages.isEmpty
                    ? _buildEmptyState(provider)
                    : _buildMessagesList(provider),
              ),

              // Typing indicator
              if (provider.isTyping) _buildTypingIndicator(),

              // Suggested prompts (only show when no messages)
              if (provider.messages.isEmpty) _buildSuggestedPrompts(provider),

              // Input field
              ChatInputField(
                onSend: (text) => _handleSendMessage(text, provider),
                enabled: !provider.isTyping,
              ),
            ],
          );
        },
      ),
    );
  }

  Widget _buildEmptyState(MulaBotProvider provider) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(24.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            AppText.large(
              context.localize.hiWhatsOnYourMind('Phil'),
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.w400,
                color: AppColors.primaryText(context),
              ),
              align: TextAlign.center,
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildMessagesList(MulaBotProvider provider) {
    WidgetsBinding.instance.addPostFrameCallback((_) => _scrollToBottom());

    return ListView.builder(
      controller: _scrollController,
      padding: const EdgeInsets.only(top: 16, bottom: 16),
      itemCount: provider.messages.length,
      itemBuilder: (context, index) {
        return ChatMessageBubble(message: provider.messages[index]);
      },
    );
  }

  Widget _buildTypingIndicator() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      child: Row(
        children: [
          Image.asset(ImageAssets.ai, width: 32, height: 32),
          const SizedBox(width: 12),
          AppText.small(
            context.localize.mulaBotIsTyping,
            style: TextStyle(
              color: AppColors.secondaryText(context),
              fontStyle: FontStyle.italic,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildSuggestedPrompts(MulaBotProvider provider) {
    final prompts = [
      context.localize.whichInvestmentsLowRisk,
      context.localize.suggestBeginnerPlan,
      context.localize.howDoIStartInvesting,
      context.localize.explainTreasuryBills,
    ];

    return SizedBox(
      height: 60,
      child: SingleChildScrollView(
        scrollDirection: Axis.horizontal,
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
        child: Row(
          children: prompts
              .map(
                (prompt) => Padding(
                  padding: const EdgeInsets.only(right: 8),
                  child: SuggestedPromptChip(
                    text: prompt,
                    onTap: () => _handlePromptTap(prompt, provider),
                  ),
                ),
              )
              .toList(),
        ),
      ),
    );
  }
}
