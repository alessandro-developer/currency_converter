import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:formz/formz.dart';

import 'package:currency_converter/data.dart';

part 'home_state.dart';

class HomeCubit extends Cubit<HomeState> {
  HomeCubit() : super(HomeState());

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
  }

  /// MENU TOGGLE:
  void manageMenuToggle({required bool showMenu}) => emit(
    state.copyWith(
      showMenu: showMenu,
    ),
  );

  /// SELECT CURRENCY:
  void selectCurrency({required String code, required String name}) {
    emit(
      state.copyWith(
        selectedCurrencyCode: code,
        selectedCurrencyName: name,
        showMenu: false,
      ),
    );
  }
}
