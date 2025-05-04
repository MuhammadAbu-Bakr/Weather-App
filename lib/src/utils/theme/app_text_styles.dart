import 'package:flutter/material.dart';

class AppTextStyles {
  // Common styles
  static const TextStyle headline1 = TextStyle(
    fontSize: 32,
    fontWeight: FontWeight.bold,
    letterSpacing: -1.5,
  );

  static const TextStyle headline2 = TextStyle(
    fontSize: 24,
    fontWeight: FontWeight.bold,
    letterSpacing: -0.5,
  );

  static const TextStyle bodyText1 = TextStyle(
    fontSize: 16,
    fontWeight: FontWeight.normal,
  );

  static const TextStyle bodyText2 = TextStyle(
    fontSize: 14,
    fontWeight: FontWeight.normal,
  );

  // Weather-specific styles
  static TextStyle temperatureLarge(BuildContext context) {
    return TextStyle(
      fontSize: 72,
      fontWeight: FontWeight.w300,
      color: Theme.of(context).textTheme.headline1?.color,
    );
  }

  static TextStyle weatherCondition(BuildContext context) {
    return TextStyle(
      fontSize: 20,
      fontWeight: FontWeight.bold,
      color: Theme.of(context).textTheme.headline2?.color,
      letterSpacing: 1.2,
    );
  }

  static TextStyle weatherDetailLabel(BuildContext context) {
    return TextStyle(
      fontSize: 14,
      color: Theme.of(context).textTheme.caption?.color,
    );
  }

  static TextStyle weatherDetailValue(BuildContext context) {
    return TextStyle(
      fontSize: 18,
      fontWeight: FontWeight.bold,
      color: Theme.of(context).textTheme.headline2?.color,
    );
  }
}