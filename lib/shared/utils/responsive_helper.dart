import 'package:flutter/material.dart';

class ResponsiveBreakpoints {
  ResponsiveBreakpoints._();

  static const double mobileMaxWidth = 768.0;
  static const double tabletMinWidth = 769.0;
  static const double tabletMaxWidth = 1024.0;
  static const double desktopMinWidth = 1025.0;
}

class ResponsiveHelper {
  ResponsiveHelper._();

  // Default scaling multipliers (Industry Standard)
  static const double _tabletScaleMultiplier = 1.2;
  static const double _desktopScaleMultiplier = 1.4;

  // Font scaling multipliers (Conservative - closer to Material Design)
  static const double _tabletFontMultiplier = 1.125; // Was 1.2
  static const double _desktopFontMultiplier = 1.25; // Was 1.4

  // Padding scaling multipliers (Industry Standard - Material Design)
  static const double _tabletPaddingMultiplier = 1.25; // Was 1.5
  static const double _desktopPaddingMultiplier = 1.5; // Was 2.0

  // Spacing scaling multipliers (Perfect - matches Material Design)
  static const double _tabletSpacingMultiplier = 1.2;
  static const double _desktopSpacingMultiplier = 1.5;

  static bool isMobile(BuildContext context) {
    return MediaQuery.of(context).size.width <
        ResponsiveBreakpoints.tabletMinWidth;
  }

  static bool isTablet(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    return width >= ResponsiveBreakpoints.tabletMinWidth &&
        width <= ResponsiveBreakpoints.tabletMaxWidth;
  }

  static bool isDesktop(BuildContext context) {
    return MediaQuery.of(context).size.width >=
        ResponsiveBreakpoints.desktopMinWidth;
  }

  static bool isTabletOrDesktop(BuildContext context) {
    return MediaQuery.of(context).size.width >=
        ResponsiveBreakpoints.tabletMinWidth;
  }

  static bool isLandscape(BuildContext context) {
    return MediaQuery.of(context).orientation == Orientation.landscape;
  }

  static bool isPortrait(BuildContext context) {
    return MediaQuery.of(context).orientation == Orientation.portrait;
  }

  static double getScreenWidth(BuildContext context) {
    return MediaQuery.of(context).size.width;
  }

  static double getScreenHeight(BuildContext context) {
    return MediaQuery.of(context).size.height;
  }

  /// Auto-scales values for all screen types with built-in multipliers
  /// If tablet/desktop values aren't provided, they're automatically calculated
  static T responsiveValue<T>(
    BuildContext context, {
    required T mobile,
    T? tablet,
    T? desktop,
  }) {
    if (isDesktop(context)) {
      if (desktop != null) {
        return desktop;
      }
      // Auto-scale desktop from tablet or mobile
      if (tablet != null) {
        return _scaleValue(
          tablet,
          _desktopScaleMultiplier / _tabletScaleMultiplier,
        );
      }
      return _scaleValue(mobile, _desktopScaleMultiplier);
    } else if (isTablet(context)) {
      if (tablet != null) {
        return tablet;
      }
      // Auto-scale tablet from mobile
      return _scaleValue(mobile, _tabletScaleMultiplier);
    } else {
      return mobile;
    }
  }

  /// Internal helper to scale values based on type
  static T _scaleValue<T>(T value, double multiplier) {
    if (value is double) {
      return (value * multiplier) as T;
    } else if (value is int) {
      return (value * multiplier).round() as T;
    } else if (value is EdgeInsets) {
      return (value * multiplier) as T;
    } else {
      // For other types that don't support scaling, return the original value
      return value;
    }
  }

  /// Enhanced method with landscape consideration and auto-scaling
  /// Automatically calculates missing values using built-in multipliers
  static T responsiveValueWithOrientation<T>(
    BuildContext context, {
    required T mobile,
    T? mobileL,
    T? tablet,
    T? tabletL,
    T? desktop,
  }) {
    if (isDesktop(context)) {
      if (desktop != null) {
        return desktop;
      }
      // Auto-scale desktop from tablet or mobile
      if (tablet != null) {
        return _scaleValue(
          tablet,
          _desktopScaleMultiplier / _tabletScaleMultiplier,
        );
      }
      return _scaleValue(mobile, _desktopScaleMultiplier);
    } else if (isTablet(context)) {
      if (isLandscape(context)) {
        if (tabletL != null) {
          return tabletL;
        }
        if (tablet != null) {
          return tablet;
        }
        return _scaleValue(mobile, _tabletScaleMultiplier);
      } else {
        if (tablet != null) {
          return tablet;
        }
        return _scaleValue(mobile, _tabletScaleMultiplier);
      }
    } else {
      return isLandscape(context) ? (mobileL ?? mobile) : mobile;
    }
  }

  /// Auto-scales font sizes for all screen types with built-in multipliers
  /// Tablet: mobile * 1.2, Desktop: mobile * 1.4 (if not provided)
  static double responsiveFontSize(
    BuildContext context, {
    required double mobile,
    double? tablet,
    double? desktop,
    bool adjustForLandscape = true,
  }) {
    double baseFontSize = responsiveValue(
      context,
      mobile: mobile,
      tablet: tablet ?? mobile * _tabletFontMultiplier,
      desktop: desktop ?? mobile * _desktopFontMultiplier,
    );

    // Optionally reduce font size slightly in landscape for better content fit
    if (adjustForLandscape && isLandscape(context) && isMobile(context)) {
      return baseFontSize * 0.9;
    }

    return baseFontSize;
  }

  /// Auto-scales padding for all screen types with built-in multipliers
  /// Tablet: mobile * 1.5, Desktop: mobile * 2.0 (if not provided)
  static EdgeInsets responsivePadding(
    BuildContext context, {
    required EdgeInsets mobile,
    EdgeInsets? tablet,
    EdgeInsets? desktop,
    bool adjustForLandscape = true,
  }) {
    EdgeInsets basePadding = responsiveValue(
      context,
      mobile: mobile,
      tablet: tablet ?? mobile * _tabletPaddingMultiplier,
      desktop: desktop ?? mobile * _desktopPaddingMultiplier,
    );

    // Optionally reduce vertical padding in landscape
    if (adjustForLandscape && isLandscape(context)) {
      return EdgeInsets.fromLTRB(
        basePadding.left,
        basePadding.top * 0.7,
        basePadding.right,
        basePadding.bottom * 0.7,
      );
    }

    return basePadding;
  }

  /// Auto-scales spacing for all screen types with built-in multipliers
  /// Tablet: mobile * 1.2, Desktop: mobile * 1.5 (if not provided)
  static double responsiveSpacing(
    BuildContext context, {
    required double mobile,
    double? tablet,
    double? desktop,
    bool adjustForLandscape = true,
  }) {
    double baseSpacing = responsiveValue(
      context,
      mobile: mobile,
      tablet: tablet ?? mobile * _tabletSpacingMultiplier,
      desktop: desktop ?? mobile * _desktopSpacingMultiplier,
    );

    // Optionally reduce spacing in landscape on mobile
    if (adjustForLandscape && isLandscape(context) && isMobile(context)) {
      return baseSpacing * 0.8;
    }

    return baseSpacing;
  }

  static int responsiveColumns(BuildContext context) {
    if (isDesktop(context)) {
      return 4;
    } else if (isTablet(context)) {
      return 3;
    } else {
      return isLandscape(context) ? 3 : 2;
    }
  }

  // Additional helper for landscape-specific adjustments
  static double getAvailableHeight(BuildContext context) {
    final mediaQuery = MediaQuery.of(context);
    return mediaQuery.size.height -
        mediaQuery.padding.top -
        mediaQuery.padding.bottom;
  }

  // Helper for adaptive UI decisions
  static bool shouldUseCompactLayout(BuildContext context) {
    return isMobile(context) && isLandscape(context);
  }

  /// Convenience method that demonstrates auto-scaling multipliers
  /// Shows the actual values that will be used for each screen type
  static Map<String, T> getScaledValues<T>(T mobile) {
    T? tablet;
    T? desktop;

    // Auto-calculate scaled values
    if (mobile is double) {
      tablet = (mobile * _tabletScaleMultiplier) as T;
      desktop = (mobile * _desktopScaleMultiplier) as T;
    } else if (mobile is int) {
      tablet = ((mobile as int) * _tabletScaleMultiplier).round() as T;
      desktop = ((mobile as int) * _desktopScaleMultiplier).round() as T;
    } else if (mobile is EdgeInsets) {
      tablet = ((mobile as EdgeInsets) * _tabletPaddingMultiplier) as T;
      desktop = ((mobile as EdgeInsets) * _desktopPaddingMultiplier) as T;
    }

    return {
      'mobile': mobile,
      'tablet': tablet ?? mobile,
      'desktop': desktop ?? mobile,
    };
  }

  /// Get the scaling multipliers for reference
  static Map<String, Map<String, double>> getScalingMultipliers() {
    return {
      'general': {
        'tablet': _tabletScaleMultiplier,
        'desktop': _desktopScaleMultiplier,
      },
      'font': {
        'tablet': _tabletFontMultiplier,
        'desktop': _desktopFontMultiplier,
      },
      'padding': {
        'tablet': _tabletPaddingMultiplier,
        'desktop': _desktopPaddingMultiplier,
      },
      'spacing': {
        'tablet': _tabletSpacingMultiplier,
        'desktop': _desktopSpacingMultiplier,
      },
    };
  }
}
