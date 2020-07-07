class Currency {
  final String countryCode;
  final int decimalPoint;
  final String symbol;

  const Currency(this.countryCode, this.decimalPoint, {this.symbol});
}

const Currency standardRpSetting = const Currency(
  'IDR', // country code
  2, // decimal point
  symbol: 'Rp.',
);

const Currency standardRpNoSymbolSetting = const Currency(
  'IDR', // country code
  2, // decimal point
  symbol: '',
);

extension NumExt on num {
  String formatMoney({Currency currency = standardRpSetting}) {
    final wholeIdx = 0;
    final decimalIdx = 1;
    final splitStr = this.toString().split('.');
    final whole = splitStr[wholeIdx];
    final decimal = splitStr[decimalIdx];

    String addedCommaStr = '';
    for (var i = 1; i <= whole.length; i++) {
      final fromBehind = whole.length - i;
      addedCommaStr = whole[fromBehind] + addedCommaStr;
      if (i != 0 && i % 3 == 0 && (i + 1 <= whole.length))
        addedCommaStr = ',' + addedCommaStr;
    }

    final isDecimal = this != this.toInt();
    if (isDecimal) addedCommaStr += '.$decimal';

    if (currency.symbol.isNotEmpty)
      addedCommaStr = '${currency.symbol} $addedCommaStr';

    return addedCommaStr;
  }
}

extension StringExt on String {
  // Money parseMoney({Currency currency = standardRpSetting}) {
  //   return Money.parse(this, currency ?? standardRpSetting);
  // }
}
