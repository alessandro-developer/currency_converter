import 'package:currency_converter/data.dart';
import 'package:http/http.dart';

class ExchangeRateAPI {
  ExchangeRateAPI._internal();
  static final ExchangeRateAPI _instance = ExchangeRateAPI._internal();
  factory ExchangeRateAPI() => _instance;

  // Make a GET request to the server to get conversion rates:
  Future<Response> getConversionRates() async {
    final String token = 'b08d8f85620aeaedd1a47190';

    return get(
      Uri.parse('$endpointV6/$token/latest/USD'),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=utf-8',
      },
    );
  }

  // Make a GET request to the server to get the list of supported codes:
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
