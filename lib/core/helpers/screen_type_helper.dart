import 'dart:io';

import 'package:flutter/material.dart';

class ScreenTypeHelper extends StatelessWidget {
  const ScreenTypeHelper({
    super.key,
    required this.tablet,
    required this.desktop,
    required this.mobile,
  });
  final Widget mobile;
  final Widget tablet;
  final Widget desktop;

  @override
  Widget build(BuildContext context) {
    return Responsive(
      mobile: mobile,
      tablet: tablet,
      desktop: desktop,
    );
  }
}

class Responsive extends StatelessWidget {
  const Responsive({
    super.key,
    required this.mobile,
    required this.tablet,
    required this.desktop,
  });
  final Widget mobile;
  final Widget tablet;
  final Widget desktop;

  // This isMobile, isTablet, isDesktop help us later
  static bool isMobile(BuildContext context) =>
      MediaQuery.sizeOf(context).width <= 480 &&
      MediaQuery.orientationOf(context) == Orientation.portrait &&
      !Platform.isWindows &&
      !Platform.isMacOS;

  static bool isSmallTablet(BuildContext context) =>
      MediaQuery.sizeOf(context).width > 480 &&
      MediaQuery.sizeOf(context).width < 700 &&
      !Platform.isWindows &&
      !Platform.isMacOS;

  static bool isTablet(BuildContext context) =>
      MediaQuery.sizeOf(context).width > 480 &&
      !Platform.isWindows &&
      !Platform.isMacOS;

  static bool isDesktop(BuildContext context) =>
      Platform.isWindows || Platform.isMacOS;

  @override
  Widget build(BuildContext context) {
    return OrientationBuilder(
      builder: (context, orientation) {
        if (isTablet(context)) {
          switch (orientation) {
            case Orientation.landscape:
              return tablet;
            case Orientation.portrait:
              return mobile;

            default:
              return tablet;
          }
        } else if (isMobile(context)) {
          switch (orientation) {
            case Orientation.landscape:
              return mobile;
            case Orientation.portrait:
              return mobile;
            default:
              return mobile;
          }
        }
        return desktop;
      },
    );
  }
}
