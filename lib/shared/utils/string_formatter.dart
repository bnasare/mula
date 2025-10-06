// Helper method to add line break before the last word
String formatTitleWithLineBreak(String title) {
  final words = title.trim().split(' ');
  if (words.length <= 1) {
    return title; // Return as is if there's only one word or empty
  }

  // Join all words except the last one, then add line break before the last word
  final allButLast = words.sublist(0, words.length - 1).join(' ');
  final lastWord = words.last;

  return '$allButLast\n$lastWord';
}
