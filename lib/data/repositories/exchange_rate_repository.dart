import 'dart:convert';
import 'dart:developer' as developer;

import 'package:http/http.dart';

import 'package:currency_converter/data.dart';

class ExchangeRateRepository {
  ExchangeRateRepository._internal();
  static final ExchangeRateRepository _instance = ExchangeRateRepository._internal();
  factory ExchangeRateRepository() => _instance;

  final ExchangeRateProvider _exchangeRateProvider = ExchangeRateProvider();
  final CacheProvider _cacheProvider = CacheProvider();

  /// Retrieve conversion rates, from cache (daily check) or through API call:
  Future<ResultsConversionRatesModel> getConversionRates() async {
    // Reads the last cached timestamp:
    final String? lastUpdateString = await _cacheProvider.getLastUpdateTimestampString();
    DateTime? lastUpdateDate;

    if (lastUpdateString != null) {
      try {
        lastUpdateDate = DateTime.parse(lastUpdateString);
      } catch (e) {
        developer.log('getConversionRates => No timestamp found in cache: $e');
        lastUpdateDate = null;
      }
    }

    final DateTime now = DateTime.now();
    // Check if a cache update is needed via API call (new day or timestamp not valid):
    final bool needsApiUpdate = lastUpdateDate == null || !isSameDay(lastUpdateDate, now);

    ResultsConversionRatesModel? localData;

    // If a cache update is not required, upload the data from the cache:
    if (!needsApiUpdate) {
      developer.log('getConversionRates => Data has been retrieved from cache. Last update was today.');

      localData = await _cacheProvider.loadConversionRatesLocally();
      if (localData != null && localData.conversionRates.isNotEmpty) {
        // Return data from cache if valid:
        developer.log('getConversionRates => Serving conversion rates from cache (updated today).');
        return localData;
      } else {
        // Invalid/empty cache, force API call:
        developer.log('getConversionRates => Cache is empty or invalid despite timestamp being today. Forcing API fetch.');
      }
    }

    // Retrieves data from API (or new day or invalid/empty cache):
    developer.log('getConversionRates => Fetching conversion rates from API due to new day or empty/invalid cache...');
    final Response response = await _exchangeRateProvider.getConversionRates();

    if (response.statusCode < 200 || response.statusCode > 299) {
      developer.log('HTTP FAILURE CODE: ${response.statusCode} - ${response.reasonPhrase} => getConversionRates');
      developer.log('HTTP FAILURE BODY: ${response.body} <= getConversionRates');

      throw ApiFailure.fromResponse(response.statusCode, response.body);
    } else {
      developer.log('HTTP SUCCESS CODE: ${response.statusCode} - ${response.reasonPhrase} => getConversionRates');

      final String utf8body = utf8.decode(response.bodyBytes);
      Map<String, dynamic> body = jsonDecode(utf8body);

      if (body.isEmpty) {
        return ResultsConversionRatesModel();
      } else {
        final ResultsConversionRatesModel resultsConversionRates = ResultsConversionRatesModel.fromMap(body);

        // Save API call data in cache and update timestamp:
        await _cacheProvider.saveConversionRatesLocally(resultsConversionRates);
        return resultsConversionRates;
      }
    }
  }

  /// Check if two DateTime are the same:
  bool isSameDay(DateTime date1, DateTime date2) {
    return date1.year == date2.year && date1.month == date2.month && date1.day == date2.day;
  }

  /// Retrieve supported codes, from cache or API call:
  Future<ResultsSupportedCodesModel> getSupportedCodes() async {
    // Try to load data from the cache:
    final ResultsSupportedCodesModel? localData = await _cacheProvider.loadSupportedCodesLocally();

    if (localData != null && localData.supportedCodes.isNotEmpty) {
      developer.log('getSupportedCodes => Supported codes were retrieved from cache.');
      return localData;
    }

    // If there is no data cached, retrieve the data from the API call:
    developer.log('getSupportedCodes => Fetching supported codes from API...');
    final Response response = await _exchangeRateProvider.getSupportedCodes();

    if (response.statusCode < 200 || response.statusCode > 299) {
      developer.log('HTTP FAILURE CODE: ${response.statusCode} - ${response.reasonPhrase} => getSupportedCodes');
      developer.log('HTTP FAILURE BODY: ${response.body} <= getSupportedCodes');

      throw ApiFailure.fromResponse(response.statusCode, response.body);
    } else {
      developer.log('HTTP SUCCESS CODE: ${response.statusCode} - ${response.reasonPhrase} => getSupportedCodes');

      final String utf8body = utf8.decode(response.bodyBytes);
      Map<String, dynamic> body = jsonDecode(utf8body);

      if (body.isEmpty) {
        return ResultsSupportedCodesModel();
      } else {
        final ResultsSupportedCodesModel resultsSupportedCodes = ResultsSupportedCodesModel.fromMap(body);

        // Save API call data in cache:
        await _cacheProvider.saveSupportedCodesLocally(resultsSupportedCodes);
        return resultsSupportedCodes;
      }
    }
  }
}
