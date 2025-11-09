class Validator {
  static String? name(String? value) {
    if (value == null || value.isEmpty) {
      return 'Please enter your name';
    }

    // Check for valid characters
    if (!RegExp(r"^[a-zA-Z'\- ]+$").hasMatch(value)) {
      return 'Please enter a valid name';
    }

    // Check for at least two words (full name)
    final words = value
        .trim()
        .split(' ')
        .where((word) => word.isNotEmpty)
        .toList();
    if (words.length < 2) {
      return 'Please enter your full name (first and last name)';
    }

    return null;
  }

  static String? username(String? value) {
    if (value == null || value.isEmpty) {
      return 'Please enter a username';
    }

    // Check for valid characters (letters, numbers, underscore, hyphen)
    if (!RegExp(r"^[a-zA-Z0-9_-]+$").hasMatch(value)) {
      return 'Username can only contain letters, numbers, underscore and hyphen';
    }

    // Check for minimum length
    if (value.length < 4) {
      return 'Username must be at least 4 characters long';
    }

    // Check for maximum length
    if (value.length > 20) {
      return 'Username cannot exceed 20 characters';
    }

    return null;
  }

  static String? email(String? value) {
    if (value!.isEmpty) {
      return 'Please enter an email address';
    }
    if (!RegExp(r'^[\w-]+(\.[\w-]+)*@[\w-]+(\.[\w-]+)+$').hasMatch(value)) {
      return 'Please enter a valid email address';
    }
    return null;
  }

  static String? password(String? value) {
    if (value!.isEmpty) {
      return 'Please enter a password';
    }
    if (value.length < 6) {
      return 'Password must be at least 6 characters long';
    }
    return null;
  }

  static String? collectionName(String? value) {
    if (value!.isEmpty) {
      return 'Please enter a collection name';
    }
    if (!RegExp(r"^[a-zA-Z'\- ]+$").hasMatch(value)) {
      return 'Please enter a valid collection name';
    }
    return null;
  }

  static String? validateYouTubeUrl(String? value) {
    if (value == null || value.isEmpty) {
      return null; // Optional field
    }

    final youtubeRegex = RegExp(
      r'^https?:\/\/(?:www\.)?(?:youtube\.com\/watch\?v=|youtu\.be\/)([a-zA-Z0-9_-]{11})',
      caseSensitive: false,
    );

    if (!youtubeRegex.hasMatch(value)) {
      return 'Please enter a valid YouTube URL';
    }

    return null;
  }
}
