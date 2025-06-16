part of 'home_cubit.dart';

class HomeState extends Equatable {
  final Ammount ammount;
  final FormzSubmissionStatus status;
  final bool isValid;
  final bool showMenu;
  final String selectedCurrencyCode;
  final String selectedCurrencyName;

  const HomeState({
    this.ammount = const Ammount.dirty('1'),
    this.status = FormzSubmissionStatus.initial,
    this.isValid = false,
    this.showMenu = false,
    this.selectedCurrencyCode = 'USD',
    this.selectedCurrencyName = 'United States Dollar',
  });

  HomeState copyWith({
    Ammount? ammount,
    FormzSubmissionStatus? status,
    bool? isValid,
    bool? showMenu,
    String? selectedCurrencyCode,
    String? selectedCurrencyName,
  }) {
    return HomeState(
      ammount: ammount ?? this.ammount,
      status: status ?? this.status,
      isValid: isValid ?? this.isValid,
      showMenu: showMenu ?? this.showMenu,
      selectedCurrencyCode: selectedCurrencyCode ?? this.selectedCurrencyCode,
      selectedCurrencyName: selectedCurrencyName ?? this.selectedCurrencyName,
    );
  }

  @override
  List<Object> get props => [ammount, status, isValid, showMenu, selectedCurrencyCode, selectedCurrencyName];
}
