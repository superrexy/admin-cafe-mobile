import 'package:intl/intl.dart';

// ignore: depend_on_referenced_packages

extension FormatCurrencyIDR on int {
  String formatCurrencyIDR() {
    final formatter = NumberFormat.currency(
      locale: 'id_ID',
      symbol: 'Rp ',
      decimalDigits: 0,
    );
    return formatter.format(this);
  }
}

extension FormatDate on DateTime {
  String formatDateToString(String format) {
    final formatter = DateFormat(format);
    String formatted = formatter.format(this);
    return formatted;
  }
}
