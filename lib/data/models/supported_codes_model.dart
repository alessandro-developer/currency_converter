import 'dart:convert';

import 'package:equatable/equatable.dart';

class SupportedCodesModel extends Equatable {
  final String code;
  final String name;

  const SupportedCodesModel({
    this.code = '',
    this.name = '',
  });

  SupportedCodesModel copyWith({
    String? code,
    String? name,
  }) {
    return SupportedCodesModel(
      code: code ?? this.code,
      name: name ?? this.name,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'code': code,
      'name': name,
    };
  }

  factory SupportedCodesModel.fromMap(Map<String, dynamic> map) {
    return SupportedCodesModel(
      code: map['code'] as String,
      name: map['name'] as String,
    );
  }

  String toJson() => json.encode(toMap());

  factory SupportedCodesModel.fromJson(String source) => SupportedCodesModel.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  bool get stringify => true;

  @override
  List<Object> get props => [code, name];
}
