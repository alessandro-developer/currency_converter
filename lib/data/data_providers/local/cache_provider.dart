import 'dart:developer' as developer;

import 'package:shared_preferences/shared_preferences.dart';

import 'package:currency_converter/data.dart';

class CacheProvider {
  CacheProvider._internal();
  static final CacheProvider _instance = CacheProvider._internal();
  factory CacheProvider() => _instance;

  /// KEY TO CONVERSION RATES:
  static const String _conversionRatesKey = 'conversionRatesData';
  static const String _lastUpdateTimestampKey = 'lastConversionRatesUpdate';

  /// KEY FOR SUPPORTED CODES:
  static const String _supportedCodesKey = 'supportedCodesData';

  /// SAVE CURRENT CONVEERSION RATES AND TIMESTAMP WITHIN THE DEVICE:
  Future<void> saveConversionRatesLocally(ResultsConversionRatesModel data) async {
    try {
      final SharedPreferences prefs = await SharedPreferences.getInstance();

      await prefs.setString(_conversionRatesKey, data.toJson());
      await prefs.setString(_lastUpdateTimestampKey, DateTime.now().toIso8601String());

      developer.log('Conversion rates and timestamp saved locally.');
    } catch (e) {
      developer.log('Error saving conversion rates locally: $e');
    }
  }

  /// READES CONVERSION RATES FROM THE DEVICE:
  Future<ResultsConversionRatesModel?> loadConversionRatesLocally() async {
    try {
      final SharedPreferences prefs = await SharedPreferences.getInstance();
      final String? jsonString = prefs.getString(_conversionRatesKey);

      if (jsonString != null && jsonString.isNotEmpty) {
        developer.log('Conversion rates loaded from local storage.');

        return ResultsConversionRatesModel.fromJson(jsonString);
      }

      developer.log('No conversion rates data found in local storage.');
      return null;
    } catch (e) {
      developer.log('Error loading conversion rates locally: $e');
      return null;
    }
  }

  /// READES FROM THE DEVICE THE LAST SAVED TIMESTAMP ASSOCIATED WITH CONVERSION RATES:
  Future<String?> getLastUpdateTimestampString() async {
    try {
      final SharedPreferences prefs = await SharedPreferences.getInstance();

      return prefs.getString(_lastUpdateTimestampKey);
    } catch (e) {
      developer.log('Error getting last update timestamp: $e');
      return null;
    }
  }

  /// SAVE (ONE-TIME) SUPPORTED CODES WITHIN THE DEVICE:
  Future<void> saveSupportedCodesLocally(ResultsSupportedCodesModel data) async {
    try {
      final SharedPreferences prefs = await SharedPreferences.getInstance();

      await prefs.setString(_supportedCodesKey, data.toJson());

      developer.log('Supported codes saved locally.');
    } catch (e) {
      developer.log('Error saving supported codes locally: $e');
    }
  }

  /// READES CODES SUPPORTED BY THE DEVICE:
  Future<ResultsSupportedCodesModel?> loadSupportedCodesLocally() async {
    try {
      final SharedPreferences prefs = await SharedPreferences.getInstance();

      final String? jsonString = prefs.getString(_supportedCodesKey);

      if (jsonString != null && jsonString.isNotEmpty) {
        developer.log('Supported codes loaded from local storage.');

        return ResultsSupportedCodesModel.fromJson(jsonString);
      }

      developer.log('No supported codes data found in local storage.');
      return null;
    } catch (e) {
      developer.log('Error loading supported codes locally: $e');
      return null;
    }
  }
}
