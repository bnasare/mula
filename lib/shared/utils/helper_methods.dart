int parseDuration(String duration) {
  final RegExp regex = RegExp(
    r'(\d+)\s*(hr|hour|min|minute)s?',
    caseSensitive: false,
  );
  final matches = regex.allMatches(duration);

  int totalSeconds = 0;
  for (final match in matches) {
    final value = int.tryParse(match.group(1) ?? '0') ?? 0;
    final unit = match.group(2)?.toLowerCase() ?? '';

    if (unit.startsWith('hr') || unit.startsWith('hour')) {
      totalSeconds += value * 3600; // hours to seconds
    } else if (unit.startsWith('min')) {
      totalSeconds += value * 60; // minutes to seconds
    }
  }

  return totalSeconds;
}

String formatDuration(int seconds) {
  if (seconds < 60) {
    return '$seconds sec';
  } else if (seconds < 3600) {
    final minutes = (seconds / 60).round();
    return '$minutes min';
  } else {
    final hours = (seconds / 3600).floor();
    final minutes = ((seconds % 3600) / 60).round();
    if (minutes == 0) {
      return '$hours hr';
    } else {
      return '$hours hr $minutes min';
    }
  }
}

String getTimeAgo(DateTime dateTime) {
  final now = DateTime.now();
  final difference = now.difference(dateTime);

  if (difference.inDays > 0) {
    return '${difference.inDays}d ago';
  } else if (difference.inHours > 0) {
    return '${difference.inHours}h ago';
  } else if (difference.inMinutes > 0) {
    return '${difference.inMinutes}m ago';
  } else {
    return 'just now';
  }
}
