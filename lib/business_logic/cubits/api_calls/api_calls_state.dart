part of 'api_calls_cubit.dart';

class ApiCallsState extends Equatable {
  final ResultsConversionRatesModel resultsConversionRates;
  final ResultsSupportedCodesModel resultsSupportedCodes;
  final String errorMessage;
  final FormzSubmissionStatus getConversionRatesStatus;

  const ApiCallsState({
    this.resultsConversionRates = const ResultsConversionRatesModel(),
    this.resultsSupportedCodes = const ResultsSupportedCodesModel(),
    this.errorMessage = '',
    this.getConversionRatesStatus = FormzSubmissionStatus.initial,
  });

  ApiCallsState copyWith({
    ResultsConversionRatesModel? resultsConversionRates,
    ResultsSupportedCodesModel? resultsSupportedCodes,
    String? errorMessage,
    FormzSubmissionStatus? getConversionRatesStatus,
  }) {
    return ApiCallsState(
      resultsConversionRates: resultsConversionRates ?? this.resultsConversionRates,
      resultsSupportedCodes: resultsSupportedCodes ?? this.resultsSupportedCodes,
      errorMessage: errorMessage ?? this.errorMessage,
      getConversionRatesStatus: getConversionRatesStatus ?? this.getConversionRatesStatus,
    );
  }

  @override
  List<Object> get props => [resultsConversionRates, resultsSupportedCodes, errorMessage, getConversionRatesStatus];
}
