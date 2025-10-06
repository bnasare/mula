import 'dart:async';

import 'package:dartz/dartz.dart';
import 'package:flutter/material.dart';

import 'overlay_loading_indicator.dart';

typedef AsyncResponse<T> = Either<String, T>;

class AsyncLoader {
  static Future<AsyncResponse<T>> execute<T>({
    required BuildContext context,
    String? message,
    required Future<T> Function() asyncTask,
    Duration timeout = const Duration(seconds: 30),
    bool ignoreTimeout = false,
    String Function(Object)? errorHandler,
    bool showOverlay = true,
  }) async {
    OverlayEntry? overlayEntry;

    try {
      // Only show overlay if requested and context is mounted
      if (showOverlay && context.mounted) {
        overlayEntry = _createOverlayEntry(
          OverlayLoadingIndicator(message: message),
        );
        Overlay.of(context).insert(overlayEntry);
      }

      // Prepare the async task
      Future<T> task = asyncTask();

      // Apply timeout if not ignored
      if (!ignoreTimeout) {
        task = task.timeout(
          timeout,
          onTimeout:
              () =>
                  throw TimeoutException(
                    'Operation timed out after ${timeout.inSeconds} seconds',
                    timeout,
                  ),
        );
      }

      // Execute the task
      final T result = await task;

      // Clean up overlay
      _safelyRemoveOverlay(overlayEntry, context);

      return right(result);
    } on TimeoutException catch (e) {
      _safelyRemoveOverlay(overlayEntry, context);

      final errorMessage =
          errorHandler?.call(e) ??
          'Request timed out after ${timeout.inSeconds} seconds';
      return left(errorMessage);
    } catch (e) {
      _safelyRemoveOverlay(overlayEntry, context);

      final errorMessage =
          errorHandler?.call(e) ?? e.toString();
      return left(errorMessage);
    }
  }

  /// Creates an overlay entry with the loading indicator
  static OverlayEntry _createOverlayEntry(Widget widget) {
    return OverlayEntry(
      builder:
          (_) => Material(
            color: Colors.transparent,
            child: ColoredBox(
              color: Colors.black54,
              child: Center(child: widget),
            ),
          ),
    );
  }

  /// Safely removes the overlay entry if context is still mounted
  static void _safelyRemoveOverlay(OverlayEntry? entry, BuildContext context) {
    if (entry != null && context.mounted) {
      try {
        entry.remove();
      } catch (e) {
        // Overlay might have already been removed or context disposed
        // Silently handle this case
        debugPrint('AsyncLoader: Failed to remove overlay - $e');
      }
    }
  }

  /// Convenience method for simple async operations without custom error handling
  static Future<AsyncResponse<T>> executeSimple<T>({
    required BuildContext context,
    required Future<T> Function() asyncTask,
    String? loadingMessage,
    Duration timeout = const Duration(seconds: 30),
  }) async {
    return execute<T>(
      context: context,
      message: loadingMessage,
      asyncTask: asyncTask,
      timeout: timeout,
      ignoreTimeout: false,
      showOverlay: true,
    );
  }

  /// Convenience method for background operations without loading overlay
  static Future<AsyncResponse<T>> executeBackground<T>({
    required Future<T> Function() asyncTask,
    Duration timeout = const Duration(seconds: 30),
    bool ignoreTimeout = false,
    String Function(Object)? errorHandler,
  }) async {
    try {
      Future<T> task = asyncTask();

      if (!ignoreTimeout) {
        task = task.timeout(
          timeout,
          onTimeout:
              () =>
                  throw TimeoutException(
                    'Operation timed out after ${timeout.inSeconds} seconds',
                    timeout,
                  ),
        );
      }

      final T result = await task;
      return right(result);
    } on TimeoutException catch (e) {
      final errorMessage =
          errorHandler?.call(e) ??
          'Request timed out after ${timeout.inSeconds} seconds';
      return left(errorMessage);
    } catch (e) {
      final errorMessage =
          errorHandler?.call(e) ?? e.toString();
      return left(errorMessage);
    }
  }
}
