import 'package:logger/logger.dart';

class LogService {
  static final Logger _logger = Logger(
    printer: PrettyPrinter(
      methodCount: 2,
      lineLength: 120,
      colors: true,
      printEmojis: true,
      dateTimeFormat: DateTimeFormat.dateAndTime,
    ),
  );

  static void logInfo(String message) {
    _logger.i(message);
  }

  static void logError(String message, dynamic error, StackTrace? stackTrace) {
    _logger.e('$message\n$error', error: error, stackTrace: stackTrace);
  }

  static void logResponse(String endpoint, dynamic response) {
    _logger.i('Response from $endpoint: ${response.toString()}');
  }
}
