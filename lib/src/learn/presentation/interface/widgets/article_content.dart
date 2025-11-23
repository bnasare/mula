import 'package:flutter/material.dart';
import '../../../../../shared/presentation/theme/app_colors.dart';
import '../../../../../shared/presentation/widgets/constants/app_text.dart';

class ArticleContent extends StatelessWidget {
  final String content;

  const ArticleContent({super.key, required this.content});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: _parseContent(context, content),
    );
  }

  List<Widget> _parseContent(BuildContext context, String content) {
    final List<Widget> widgets = [];
    final lines = content.split('\n');

    for (int i = 0; i < lines.length; i++) {
      final line = lines[i];

      if (line.trim().isEmpty) {
        widgets.add(const SizedBox(height: 12));
        continue;
      }

      // Bold headings (text between **)
      if (line.startsWith('**') && line.endsWith('**')) {
        final text = line.replaceAll('**', '');
        widgets.add(
          Padding(
            padding: const EdgeInsets.only(bottom: 8),
            child: AppText.small(
              text,
              style: const TextStyle(fontWeight: FontWeight.bold),
            ),
          ),
        );
      }
      // Numbered list items
      else if (RegExp(r'^\d+\.').hasMatch(line)) {
        widgets.add(
          Padding(
            padding: const EdgeInsets.only(bottom: 8, left: 8),
            child: _parseRichText(context, line),
          ),
        );
      }
      // Bullet points
      else if (line.trim().startsWith('•')) {
        widgets.add(
          Padding(
            padding: const EdgeInsets.only(bottom: 8, left: 8),
            child: _parseRichText(context, line),
          ),
        );
      }
      // Regular paragraphs
      else {
        widgets.add(
          Padding(
            padding: const EdgeInsets.only(bottom: 12),
            child: _parseRichText(context, line),
          ),
        );
      }
    }

    return widgets;
  }

  Widget _parseRichText(BuildContext context, String text) {
    final spans = <InlineSpan>[];
    final regex = RegExp(r'\*\*(.*?)\*\*');
    int lastMatchEnd = 0;

    for (final match in regex.allMatches(text)) {
      // Add text before the match
      if (match.start > lastMatchEnd) {
        spans.add(
          TextSpan(
            text: text.substring(lastMatchEnd, match.start),
            style: TextStyle(
              fontSize: 16,
              color: AppColors.primaryText(context),
              height: 1.6,
            ),
          ),
        );
      }

      // Add the bold text
      spans.add(
        TextSpan(
          text: match.group(1),
          style: TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.bold,
            color: AppColors.primaryText(context),
            height: 1.6,
          ),
        ),
      );

      lastMatchEnd = match.end;
    }

    // Add remaining text
    if (lastMatchEnd < text.length) {
      spans.add(
        TextSpan(
          text: text.substring(lastMatchEnd),
          style: TextStyle(
            fontSize: 16,
            color: AppColors.primaryText(context),
            height: 1.6,
          ),
        ),
      );
    }

    return RichText(text: TextSpan(children: spans));
  }
}
