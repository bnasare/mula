import 'package:flutter/material.dart';
import 'package:loading_indicator/loading_indicator.dart';

import 'responsive_helper.dart';

extension CustomElevatedButtonExtension on ElevatedButton {
  ElevatedButton withLoadingState({
    required VoidCallback? onPressed,
    required String text,
    required BuildContext context,
    bool loading = false,
  }) {
    return ElevatedButton(
      onPressed: (loading || onPressed == null) ? null : onPressed,
      child:
          loading
              ? LoadingIndicator(
                indicatorType: Indicator.ballPulse,
                colors: [Theme.of(context).colorScheme.primary],
              )
              : Text(text),
    );
  }
}

extension StringExtension on String {
  String capitalize() {
    if (isEmpty) {
      return this;
    }
    return this[0].toUpperCase() + substring(1);
  }
}

extension ResponsiveContext on BuildContext {
  bool get isMobile => ResponsiveHelper.isMobile(this);
  bool get isTablet => ResponsiveHelper.isTablet(this);
  bool get isDesktop => ResponsiveHelper.isDesktop(this);
  bool get isTabletOrDesktop => ResponsiveHelper.isTabletOrDesktop(this);
  bool get isLandscape => ResponsiveHelper.isLandscape(this);
  bool get isPortrait => ResponsiveHelper.isPortrait(this);

  double get screenWidth => ResponsiveHelper.getScreenWidth(this);
  double get screenHeight => ResponsiveHelper.getScreenHeight(this);

  T responsiveValue<T>({required T mobile, T? tablet, T? desktop}) =>
      ResponsiveHelper.responsiveValue(
        this,
        mobile: mobile,
        tablet: tablet,
        desktop: desktop,
      );

  double responsiveFontSize({
    required double mobile,
    double? tablet,
    double? desktop,
  }) => ResponsiveHelper.responsiveFontSize(
    this,
    mobile: mobile,
    tablet: tablet,
    desktop: desktop,
  );

  EdgeInsets responsivePadding({
    required EdgeInsets mobile,
    EdgeInsets? tablet,
    EdgeInsets? desktop,
  }) => ResponsiveHelper.responsivePadding(
    this,
    mobile: mobile,
    tablet: tablet,
    desktop: desktop,
  );

  double responsiveSpacing({
    required double mobile,
    double? tablet,
    double? desktop,
  }) => ResponsiveHelper.responsiveSpacing(
    this,
    mobile: mobile,
    tablet: tablet,
    desktop: desktop,
  );

  int get responsiveColumns => ResponsiveHelper.responsiveColumns(this);
}

bool compareMaps(Map<dynamic, dynamic> map1, Map<dynamic, dynamic> map2) {
  if (map1.length != map2.length) {
    return false;
  }
  for (final key in map1.keys) {
    if (!map2.containsKey(key) || map2[key] != map1[key]) {
      return false;
    }
  }
  return true;
}
