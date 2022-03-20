import 'package:expense_bud/features/settings/domain/entities/currency.dart';

const usd = CurrencyEntity(name: 'USD', locale: "en_US", symbol: "\u0024");
const ngn = CurrencyEntity(name: 'NGN', locale: "en_NG", symbol: "\u20A6");
const gbp = CurrencyEntity(name: 'GBP', locale: "en_GB", symbol: "\u00A3");
const brl = CurrencyEntity(name: 'BRL', locale: "pt_BR", symbol: "\u0052\u0024");
const inr = CurrencyEntity(name: 'INR', locale: "en_IN", symbol: "\u20B9");
const eur = CurrencyEntity(name: 'EUR', locale: "it_IT", symbol: "\u20AC");

List<CurrencyEntity> currencyList() => [usd, gbp, ngn, brl, inr, eur];
