import 'dart:convert';

import 'package:flutter/foundation.dart';

class ExchangeRateDto {
  final String result;
  final Map<String, double> rates;
  final String base;
  final String error;
  ExchangeRateDto({
    required this.result,
    required this.rates,
    required this.base,
    required this.error,
  });

  ExchangeRateDto copyWith({
    String? result,
    Map<String, double>? rates,
    String? base,
    String? error,
  }) {
    return ExchangeRateDto(
      result: result ?? this.result,
      rates: rates ?? this.rates,
      base: base ?? this.base,
      error: error ?? this.error,
    );
  }

  factory ExchangeRateDto.fromMap(Map<String, dynamic> map) {
    return ExchangeRateDto(
      result: map['result'] ?? '',
      rates: Map<String, double>.from(map['conversion_rates']),
      base: map['base_code'] ?? '',
      error: map['error-type'] ?? '',
    );
  }

  factory ExchangeRateDto.fromJson(String source) =>
      ExchangeRateDto.fromMap(json.decode(source));

  @override
  String toString() {
    return 'ExchangeRateDto(result: $result, rates: $rates, base: $base, error: $error)';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
  
    return other is ExchangeRateDto &&
      other.result == result &&
      mapEquals(other.rates, rates) &&
      other.base == base &&
      other.error == error;
  }

  @override
  int get hashCode {
    return result.hashCode ^
      rates.hashCode ^
      base.hashCode ^
      error.hashCode;
  }

  Map<String, dynamic> toMap() {
    return {
      'result': result,
      'rates': rates,
      'base': base,
      'error': error,
    };
  }

  String toJson() => json.encode(toMap());
}
