
import 'package:boilerplate_flutter/core/helpers/global_helper.dart';
import 'package:intl/intl.dart';

class CurrencyFormat {
  const CurrencyFormat._();
  static String convertToIdr(dynamic number, [int decimalDigit = 0, String symbol = 'Rp ']) {
    
    final NumberFormat currencyFormatter = NumberFormat.currency(
      locale: 'id',
      symbol: symbol,
      decimalDigits: GlobalHelper.isFractionGreaterFromZero((number as num).toDouble()) ? 2 :decimalDigit,
    );
    return currencyFormatter.format(number);
  }
}