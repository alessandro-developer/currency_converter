import 'dart:convert';

import 'package:equatable/equatable.dart';

class ResultsConversionRatesModel extends Equatable {
  final String baseCode;
  final Map<String, double> conversionRates;

  const ResultsConversionRatesModel({
    this.baseCode = '',
    this.conversionRates = const <String, double>{},
  });

  ResultsConversionRatesModel copyWith({
    String? baseCode,
    Map<String, double>? conversionRates,
  }) {
    return ResultsConversionRatesModel(
      baseCode: baseCode ?? this.baseCode,
      conversionRates: conversionRates ?? this.conversionRates,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'base_code': baseCode,
      'conversion_rates': conversionRates,
    };
  }

  factory ResultsConversionRatesModel.fromMap(Map<String, dynamic> map) {
    final Map<String, double> parsedConversionRates = <String, double>{};

    if (map['conversion_rates'] != null) {
      (map['conversion_rates'] as Map<String, dynamic>).forEach((key, value) {
        if (value is num) parsedConversionRates[key] = value.toDouble();
      });
    }

    return ResultsConversionRatesModel(
      baseCode: map['base_code'] as String,
      conversionRates: parsedConversionRates,
    );
  }

  String toJson() => json.encode(toMap());

  factory ResultsConversionRatesModel.fromJson(String source) => ResultsConversionRatesModel.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  bool get stringify => true;

  @override
  List<Object> get props => [
    baseCode,
    conversionRates,
  ];
}
