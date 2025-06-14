import 'dart:convert';

import 'package:equatable/equatable.dart';

import 'package:currency_converter/data.dart';

class ResultsSupportedCodesModel extends Equatable {
  final List<SupportedCodesModel> supportedCodes;

  const ResultsSupportedCodesModel({
    this.supportedCodes = const <SupportedCodesModel>[],
  });

  ResultsSupportedCodesModel copyWith({
    List<SupportedCodesModel>? supportedCodes,
  }) {
    return ResultsSupportedCodesModel(
      supportedCodes: supportedCodes ?? this.supportedCodes,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'supported_codes': supportedCodes.map((x) => x.toMap()).toList(),
    };
  }

  factory ResultsSupportedCodesModel.fromMap(Map<String, dynamic> map) {
    return ResultsSupportedCodesModel(
      supportedCodes: (map['supported_codes'] as List<dynamic>).map((x) => SupportedCodesModel(code: x[0], name: x[1])).toList(),
    );
  }

  String toJson() => json.encode(toMap());

  factory ResultsSupportedCodesModel.fromJson(String source) => ResultsSupportedCodesModel.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  bool get stringify => true;

  @override
  List<Object> get props => [supportedCodes];
}
