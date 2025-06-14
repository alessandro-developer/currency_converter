import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:formz/formz.dart';

import 'package:currency_converter/data.dart';

part 'api_calls_state.dart';

class ApiCallsCubit extends Cubit<ApiCallsState> {
  ApiCallsCubit() : super(ApiCallsState());

  final ExchangeRateRepository exchangeRateRepo = ExchangeRateRepository();

  /// Get Conversion Rates:
  void getConversionRates() async {
    emit(state.copyWith(getConversionRatesStatus: FormzSubmissionStatus.inProgress));

    try {
      final ResultsConversionRatesModel resultsConversionRates = await exchangeRateRepo.getConversionRates();
      final ResultsSupportedCodesModel resultsSupportedCodes = await exchangeRateRepo.getSupportedCodes();

      emit(
        state.copyWith(
          getConversionRatesStatus: FormzSubmissionStatus.success,
          resultsConversionRates: resultsConversionRates,
          resultsSupportedCodes: resultsSupportedCodes,
        ),
      );
    } catch (e) {
      emit(
        state.copyWith(
          getConversionRatesStatus: FormzSubmissionStatus.failure,
          errorMessage: e.toString(),
        ),
      );
    }
  }
}
