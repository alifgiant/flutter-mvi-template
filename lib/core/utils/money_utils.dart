import 'package:money2/money2.dart';

Currency standardRpSetting = Currency.create(
  'IDR', // country code
  2, // decimal point
  symbol: 'Rp',
  invertSeparators: true, // thousand '.' | decimal ','
);

void registerMoneyType() {
  // register money type
  CommonCurrencies().registerAll();
  Currencies.register(standardRpSetting);
}

extension on num {
  String formatMoney({Currency currency}) {
    return Money.from(this, currency ?? standardRpSetting).toString();
  }
}

extension on String {
  Money parseMoney({Currency currency}) {
    return Money.parse(this, currency ?? standardRpSetting);
  }
}
