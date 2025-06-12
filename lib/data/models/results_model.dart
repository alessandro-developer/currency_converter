import 'dart:convert';

import 'package:equatable/equatable.dart';

import 'package:currency_converter/data.dart';

class ResultsModel extends Equatable {
  final String baseCode;
  final ConversionRatesModel conversionRates;

  const ResultsModel({
    this.baseCode = '',
    this.conversionRates = const ConversionRatesModel(),
  });

  ResultsModel copyWith({
    String? baseCode,
    ConversionRatesModel? conversionRates,
  }) {
    return ResultsModel(
      baseCode: baseCode ?? this.baseCode,
      conversionRates: conversionRates ?? this.conversionRates,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'base_code': baseCode,
      'conversion_rates': conversionRates.toMap(),
    };
  }

  factory ResultsModel.fromMap(Map<String, dynamic> map) {
    return ResultsModel(
      baseCode: map['base_code'] as String,
      conversionRates: ConversionRatesModel.fromMap(map['conversion_rates'] as Map<String, dynamic>),
    );
  }

  String toJson() => json.encode(toMap());

  factory ResultsModel.fromJson(String source) => ResultsModel.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  bool get stringify => true;

  @override
  List<Object> get props => [baseCode, conversionRates];
}
