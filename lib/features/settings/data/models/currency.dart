import 'package:hive/hive.dart';


part 'currency.g.dart';

@HiveType(typeId: 2)
class CurrencyModel extends HiveObject {
  @HiveField(0)
  final String name;
  @HiveField(1)
  final String symbol;
  @HiveField(2)
  final int minorUnits;
  @HiveField(3)
  final String? locale;

  CurrencyModel({
    required this.name,
    required this.locale,
    this.minorUnits = 2,
    this.symbol = "",
  });
}
