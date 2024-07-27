import 'dart:io';
import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class GlobalHelper {
  static bool isEmpty(value, {bool isIgnoreZero = false}) {
    if (value == '' ||
        value == null ||
        value == 'null' ||
        (value == '0' && !isIgnoreZero) ||
        value == 0) {
      return true;
    } else {
      return false;
    }
  }

  static bool isEmptyList(Iterable<dynamic>? list) {
    if (list == null) {
      return true;
    } else if (list.isEmpty) {
      return true;
    }
    return false;
  }

  static bool isBoolean(bool? value) {
    bool result = false;
    if (!isEmpty(value.toString())) {
      result = value ?? false;
    }
    return result;
  }

  static double validateNumberDouble(
    String? valueInput, {
    double defaultValue = 0.0,
  }) {
    if (isEmpty(valueInput)) {
      return _roundSixNumberAfterComasDouble(defaultValue);
    }

    return _roundSixNumberAfterComasDouble(
      double.tryParse(valueInput!) ?? defaultValue,
    );
  }

  static double _roundSixNumberAfterComasDouble(double text) {
    final String roundThreeDecimals = text.toStringAsFixed(6);
    final String removeLongerDecimal =
        double.parse(roundThreeDecimals).toString();

    return double.parse(removeLongerDecimal);
  }

  static String formatNumberToString(
    String? text, {
    String defaultValue = '0',
  }) {
    if (isEmpty(text)) {
      return defaultValue;
    }

    return double.parse(text!).toStringAsFixed(0);
  }

  static double to2Digit(double value) {
    final String number = value.toStringAsFixed(2);

    return double.parse(number);
  }

  static String to2DigitPercent(double value) {
    final String number = to2Digit(value).toString();

    return '$number%';
  }

  static String removeTrailingZero(String text) {
    if (text.isEmpty) {
      return '0';
    }

    ///NOTE: round to 3 number after comas
    String roundThreeDecimals = (double.tryParse(text) ?? 0).toStringAsFixed(3);

    ///NOTE: add zero remover for 3.000 -> 3.0, 3.27000 -> 3.27, and round to 3 number after comas
    String removeLongerDecimal =
        (double.tryParse(roundThreeDecimals) ?? 0).toString();

    ///NOTE: remove zero after comas including its comas, ex: 3.0 -> 3, 2.2 -> 2.2
    return removeLongerDecimal.replaceAll(RegExp(r'([.]*0)(?!.*\d)'), '');
  }

  static int formatTextNumberToInt(String? text, {int defaultValue = 0}) {
    if (isEmpty(text)) {
      return defaultValue;
    }
    double value = double.tryParse(text!) ?? 0.0;
    return int.parse(value.toStringAsFixed(0));
  }

  static int validateNumber(String? valueInput) {
    int value = 0;
    if (valueInput != null && valueInput != 'null' && valueInput != '') {
      value = double.parse(valueInput).round();
    }
    return value;
  }

  static bool validateBoolean(bool? valueInput) {
    bool value = false;
    if (!isEmpty(valueInput.toString())) {
      value = valueInput ?? false;
    }
    return value;
  }

  static bool isFractionGreaterFromZero(double number) {
    double fractionalPart = number - number.truncate();

    // Check if the fractional part is greater than zero
    bool isFractionalPartGreaterThanZero = fractionalPart > 0;
    return isFractionalPartGreaterThanZero;
  }
}

class ResponsiveSizeHelper {
  // CUSTOM FONT SIZE
  static double fontSizeCustom(BuildContext context, double fontSize) {
    double size = fontSize.sp;
    double size15Inch = (size / 1.4.sp).roundToDouble();
    double size10Inch = (size / 1.2.sp).roundToDouble();

    if (Platform.isWindows || Platform.isMacOS) {
      size15Inch = (size / 1.sp).roundToDouble();
      size10Inch = (size / 1.1.sp).roundToDouble();
      if (diagonalInches(context) >= 10 && diagonalInches(context) < 15) {
        size = size10Inch.spMax;
      } else if (diagonalInches(context) >= 15) {
        size = size15Inch.spMax;
      }
      return size;
    } else {
      if (diagonalInches(context) >= 10 && diagonalInches(context) < 15) {
        size = size10Inch.sp;
      } else if (diagonalInches(context) >= 15) {
        size = size15Inch.sp;
      }
      return size;
    }
  }

  static double get _ppi => (Platform.isAndroid ||
          Platform.isIOS ||
          Platform.isWindows ||
          Platform.isMacOS)
      ? 150
      : 96;
  // PIXELS
  static double diagonal(BuildContext c) {
    Size s = MediaQuery.of(c).size;
    final height = s.height + kToolbarHeight;
    return sqrt((s.width * s.width) + (height * height));
  }

  // GET INCH SCREEN
  static double diagonalInches(BuildContext c) => (diagonal(c) / _ppi + 1);

  // GET COUNT GRID CASHIER PAGE
  static int getCrossAxisCountCashier(BuildContext context) {
    int crossAxisCount = 4;
    if (diagonalInches(context) >= 10 && diagonalInches(context) < 15) {
      crossAxisCount = 5;
    } else if (diagonalInches(context) >= 15) {
      crossAxisCount = 6;
    }
    return crossAxisCount;
  }

  // GET COUNT GRID TABLE PAGE
  static int getCrossAxisCountTable(BuildContext context) {
    int crossAxisCount = 5;
    if (diagonalInches(context) >= 10 && diagonalInches(context) < 15) {
      crossAxisCount = 6;
    } else if (diagonalInches(context) >= 15) {
      crossAxisCount = 8;
    }
    return crossAxisCount;
  }

  static bool checkIsLargeScreen(BuildContext context) {
    bool isLarge = false;
    if (diagonalInches(context) >= 10) {
      isLarge = true;
    }
    return isLarge;
  }

  static double setValueByDeviceRatio({
    required BuildContext context,
    required double valueDefault,
    double? value10Inch,
    double? value15Inch,
  }) {
    double finalValue = valueDefault;

    if (diagonalInches(context) >= 10 && diagonalInches(context) < 15) {
      finalValue = value10Inch ?? finalValue;

      return finalValue;
    } else if (diagonalInches(context) >= 15) {
      finalValue = value15Inch ?? finalValue;

      return finalValue;
    }

    return finalValue;
  }
}
