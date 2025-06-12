import 'package:currency_converter/data.dart';
import 'package:http/http.dart';

class ConversionRatesAPI {
  ConversionRatesAPI._internal();
  static final ConversionRatesAPI _instance = ConversionRatesAPI._internal();
  factory ConversionRatesAPI() => _instance;

  Future<Response> getConversionRates() async {
    final String token = 'b08d8f85620aeaedd1a47190';

    return get(
      Uri.parse('$endpointV6/$token/latest/USD'),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=utf-8',
      },
    );
  }
}
