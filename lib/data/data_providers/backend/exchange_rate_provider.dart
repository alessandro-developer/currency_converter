import 'package:currency_converter/data.dart';
import 'package:http/http.dart';

class ExchangeRateProvider {
  ExchangeRateProvider._internal();
  static final ExchangeRateProvider _instance = ExchangeRateProvider._internal();
  factory ExchangeRateProvider() => _instance;

  /// MAKE A GET REQUEST TO THE SERVER TO GET CONVERSION RATES:
  Future<Response> getConversionRates() async {
    final String token = 'b08d8f85620aeaedd1a47190';

    return get(
      Uri.parse('$endpointV6/$token/latest/USD'),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=utf-8',
      },
    );
  }

  /// MAKE A GET REQUEST TO THE SERVER TO GET THE LIST OF SUPPORTED CODES:
  Future<Response> getSupportedCodes() async {
    final String token = 'b08d8f85620aeaedd1a47190';

    return get(
      Uri.parse('$endpointV6/$token/codes'),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=utf-8',
      },
    );
  }
}
