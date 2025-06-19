import 'dart:convert';

import 'package:currency_converter/data.dart';

/// GETS THE ERROR CODE FROM THE SERVER:
class ApiFailure implements Exception {
  final String code;

  const ApiFailure(this.code);

  factory ApiFailure.fromResponse(int statusCode, String? body) {
    String code;

    try {
      final Map<String, dynamic> jsonBody = json.decode(body ?? '{}');
      code = ResultsFailureModel.fromMap(jsonBody).errorType;
    } catch (_) {
      code = 'unexpected';
    }

    return ApiFailure(code);
  }

  @override
  String toString() => code;
}
