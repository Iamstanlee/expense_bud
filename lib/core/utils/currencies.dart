import 'package:expense_bud/features/settings/domain/entities/currency.dart';

const usd = CurrencyEntity(name: 'USD', locale: "en_US", symbol: "\u0024");
const ngn = CurrencyEntity(name: 'NGN', locale: "en_NG", symbol: "\u20A6");
const gbp = CurrencyEntity(name: 'GBP', locale: "en_GB", symbol: "\u00A3");

List<CurrencyEntity> currencyList() => [usd, gbp, ngn];
