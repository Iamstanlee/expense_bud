import 'package:expense_bud/features/settings/data/models/currency.dart';
import 'package:expense_bud/features/settings/domain/entities/currency.dart';

extension CurrencyEntityMapper on CurrencyEntity {
  CurrencyModel toModel() => CurrencyModel(
        name: name,
        locale: locale,
        symbol: symbol,
        minorUnits: minorUnits,
      );
}

extension CurrencyModelMapper on CurrencyModel {
  CurrencyEntity toEntity() => CurrencyEntity(
        name: name,
        locale: locale,
        symbol: symbol,
        minorUnits: minorUnits,
      );
}
