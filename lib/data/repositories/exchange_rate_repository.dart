import 'dart:convert';
import 'dart:developer' as developer;

import 'package:currency_converter/data.dart';
import 'package:http/http.dart';

class ExchangeRateRepository {
  ExchangeRateRepository._internal();
  static final ExchangeRateRepository _instance = ExchangeRateRepository._internal();
  factory ExchangeRateRepository() => _instance;

  final ExchangeRateAPI _exchangeRateAPI = ExchangeRateAPI();

  /// Gets the conversion rates from the server and manages the response:
  Future<ResultsConversionRatesModel> getConversionRates() async {
    final Response response = await _exchangeRateAPI.getConversionRates();

    if (response.statusCode < 200 || response.statusCode > 299) {
      developer.log('HTTP FAILURE CODE: ${response.statusCode} - ${response.reasonPhrase} => getConversionRates');
      developer.log('HTTP FAILURE BODY: ${response.body} <= getConversionRates');

      throw GetConversionRatesFailure.fromCode(response.statusCode, response.body);
    } else {
      developer.log('HTTP SUCCESS CODE: ${response.statusCode} - ${response.reasonPhrase} => getConversionRates');

      final String utf8body = utf8.decode(response.bodyBytes);
      Map<String, dynamic> body = jsonDecode(utf8body);

      if (body.isEmpty) {
        return ResultsConversionRatesModel();
      } else {
        return ResultsConversionRatesModel.fromMap(body);
      }
    }
  }

  /// Gets the list of supported codes from the server and manages the response:
  Future<ResultsSupportedCodesModel> getSupportedCodes() async {
    final Response response = await _exchangeRateAPI.getSupportedCodes();

    if (response.statusCode < 200 || response.statusCode > 299) {
      developer.log('HTTP FAILURE CODE: ${response.statusCode} - ${response.reasonPhrase} => getSupportedCodes');
      developer.log('HTTP FAILURE BODY: ${response.body} <= getSupportedCodes');

      throw GetSupportedCodesFailure.fromCode(response.statusCode, response.body);
    } else {
      developer.log('HTTP SUCCESS CODE: ${response.statusCode} - ${response.reasonPhrase} => getSupportedCodes');

      final String utf8body = utf8.decode(response.bodyBytes);
      Map<String, dynamic> body = jsonDecode(utf8body);

      if (body.isEmpty) {
        return ResultsSupportedCodesModel();
      } else {
        return ResultsSupportedCodesModel.fromMap(body);
      }
    }
  }
}
