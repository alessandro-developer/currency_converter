import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:formz/formz.dart';

import 'package:currency_converter/data.dart';

part 'home_state.dart';

class HomeCubit extends Cubit<HomeState> {
  HomeCubit() : super(HomeState());

  Map<String, double> _conversionRates = <String, double>{};
  List<SupportedCodesModel> _supportedCodes = <SupportedCodesModel>[];

  /// INITIALIZES CONVERSION RATES AND SUPPORTED CODES:
  void initializeConversionRates({
    required Map<String, double> rawRates,
    required List<SupportedCodesModel> supportedCodes,
  }) {
    _conversionRates = rawRates;
    _supportedCodes = supportedCodes;
    _calculateAndSortConversionRates();
  }

  /// AMMOUNT TEXTFIELD:
  void ammountChanged(String value) {
    final Ammount ammount = Ammount.dirty(value);
    final bool isValid = Formz.validate([ammount]);

    emit(
      state.copyWith(
        ammount: ammount,
        isValid: isValid,
      ),
    );

    _calculateAndSortConversionRates();
  }

  /// MENU TOGGLE:
  void manageMenuToggle({required bool showMenu}) => emit(state.copyWith(showMenu: showMenu));

  /// SELECT CURRENCY:
  void selectCurrency({required String code, required String name}) {
    emit(
      state.copyWith(
        selectedCurrencyCode: code,
        selectedCurrencyName: name,
        showMenu: false,
      ),
    );

    _calculateAndSortConversionRates();
  }

  /// CALCULATES CONVERSION RATES BASED ON USER INPUT:
  void _calculateAndSortConversionRates() {
    if (_conversionRates.isEmpty || _supportedCodes.isEmpty) {
      return;
    }

    final double amount = double.tryParse(state.ammount.value) ?? 1.0;
    final String selectedCurrencyCode = state.selectedCurrencyCode;
    final Map<String, double> newConversionRates = <String, double>{};
    final double rateOfSelectedBaseToUSD = _conversionRates[selectedCurrencyCode] ?? 1.0;
    final Map<String, double> finalConversionRates = <String, double>{};

    _conversionRates.forEach((code, rateFromUSD) => newConversionRates[code] = (rateFromUSD / rateOfSelectedBaseToUSD) * amount);

    List<MapEntry<String, double>> sortedEntries = newConversionRates.entries.toList();

    sortedEntries.sort((a, b) {
      if (a.key == selectedCurrencyCode) return -1;
      if (b.key == selectedCurrencyCode) return 1;

      return a.key.compareTo(b.key);
    });

    for (var entry in sortedEntries) {
      finalConversionRates[entry.key] = entry.value;
    }

    emit(state.copyWith(conversionRates: finalConversionRates));
  }
}
