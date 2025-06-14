import 'package:currency_converter/data.dart';

/// Gets the error code and its message from the server:
class GetConversionRatesFailure implements Exception {
  final HttpErrorType errorType;
  final String? message;

  const GetConversionRatesFailure({
    required this.errorType,
    this.message,
  });

  factory GetConversionRatesFailure.fromCode(int code, String? message) {
    if (code >= 400 && code < 500) {
      return GetConversionRatesFailure(
        errorType: HttpErrorType.clientError,
        message: message,
      );
    } else if (code >= 500 && code < 600) {
      return GetConversionRatesFailure(
        errorType: HttpErrorType.serverError,
        message: message,
      );
    } else {
      return GetConversionRatesFailure(
        errorType: HttpErrorType.unknownError,
        message: message,
      );
    }
  }
}

/// Gets the error code and its message from the server:
class GetSupportedCodesFailure implements Exception {
  final HttpErrorType errorType;
  final String? message;

  const GetSupportedCodesFailure({
    required this.errorType,
    this.message,
  });

  factory GetSupportedCodesFailure.fromCode(int code, String? message) {
    if (code >= 400 && code < 500) {
      return GetSupportedCodesFailure(
        errorType: HttpErrorType.clientError,
        message: message,
      );
    } else if (code >= 500 && code < 600) {
      return GetSupportedCodesFailure(
        errorType: HttpErrorType.serverError,
        message: message,
      );
    } else {
      return GetSupportedCodesFailure(
        errorType: HttpErrorType.unknownError,
        message: message,
      );
    }
  }
}
