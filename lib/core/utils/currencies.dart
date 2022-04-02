import 'package:expense_bud/features/settings/domain/entities/currency.dart';

const usd = CurrencyEntity(name: 'USD', locale: "en_US", symbol: "\u0024");
const eur = CurrencyEntity(name: 'EUR', locale: "en_EU", symbol: "\u20AC");
const gbp = CurrencyEntity(name: 'GBP', locale: "en_GB", symbol: "\u00A3");
const ngn = CurrencyEntity(name: 'NGN', locale: "en_NG", symbol: "\u20A6");
const jpy = CurrencyEntity(name: 'JPY', locale: "en_JP", symbol: "\u00A5");
const inr = CurrencyEntity(name: 'INR', locale: "en_IN", symbol: "\u20B9");
const brl =
    CurrencyEntity(name: 'BRL', locale: "pt_BR", symbol: "\u0052\u0024");

List<CurrencyEntity> currencyList() => [usd, eur, gbp, ngn, jpy, inr, brl];
