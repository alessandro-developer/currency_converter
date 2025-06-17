import 'dart:convert';

import 'package:equatable/equatable.dart';

class ResultsFailureModel extends Equatable {
  final String errorType;

  const ResultsFailureModel({
    this.errorType = '',
  });

  ResultsFailureModel copyWith({
    String? errorType,
  }) {
    return ResultsFailureModel(
      errorType: errorType ?? this.errorType,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'error-type': errorType,
    };
  }

  factory ResultsFailureModel.fromMap(Map<String, dynamic> map) {
    return ResultsFailureModel(
      errorType: map['error-type'] as String,
    );
  }

  String toJson() => json.encode(toMap());

  factory ResultsFailureModel.fromJson(String source) => ResultsFailureModel.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  bool get stringify => true;

  @override
  List<Object> get props => [errorType];
}
