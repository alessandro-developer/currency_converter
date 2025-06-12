import 'dart:convert';
import 'dart:developer' as developer;

import 'package:currency_converter/data.dart';
import 'package:http/http.dart';

class ConversionRatesRepository {
  ConversionRatesRepository._internal();
  static final ConversionRatesRepository _instance = ConversionRatesRepository._internal();
  factory ConversionRatesRepository() => _instance;

  final ConversionRatesAPI _pointsOfInterestApi = ConversionRatesAPI();

  Future<ResultsModel> getConversionRates() async {
    final Response response = await _pointsOfInterestApi.getConversionRates();

    if (response.statusCode < 200 || response.statusCode > 299) {
      developer.log('HTTP FAILURE CODE: ${response.statusCode} - ${response.reasonPhrase} => getConversionRates');
      developer.log('HTTP FAILURE BODY: ${response.body} <= getConversionRates');

      throw GetConversionRatesFailure.fromCode(response.statusCode, response.body);
    } else {
      developer.log('HTTP SUCCESS CODE: ${response.statusCode} - ${response.reasonPhrase} => getConversionRates');

      final String utf8body = utf8.decode(response.bodyBytes);
      Map<String, dynamic> body = jsonDecode(utf8body);

      if (body.isEmpty) {
        return ResultsModel();
      } else {
        return ResultsModel.fromMap(body);
      }
    }
  }
}
