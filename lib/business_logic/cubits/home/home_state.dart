part of 'home_cubit.dart';

class HomeState extends Equatable {
  final FormzSubmissionStatus status;
  final Ammount ammount;
  final bool isValid;
  final bool showMenu;
  final String selectedCurrencyCode;
  final String selectedCurrencyName;
  final Map<String, double> conversionRates;

  const HomeState({
    this.status = FormzSubmissionStatus.initial,
    this.ammount = const Ammount.dirty('1'),
    this.isValid = false,
    this.showMenu = false,
    this.selectedCurrencyCode = 'USD',
    this.selectedCurrencyName = 'United States Dollar',
    this.conversionRates = const <String, double>{},
  });

  HomeState copyWith({
    FormzSubmissionStatus? status,
    Ammount? ammount,
    bool? isValid,
    bool? showMenu,
    String? selectedCurrencyCode,
    String? selectedCurrencyName,
    Map<String, double>? conversionRates,
  }) {
    return HomeState(
      status: status ?? this.status,
      ammount: ammount ?? this.ammount,
      isValid: isValid ?? this.isValid,
      showMenu: showMenu ?? this.showMenu,
      selectedCurrencyCode: selectedCurrencyCode ?? this.selectedCurrencyCode,
      selectedCurrencyName: selectedCurrencyName ?? this.selectedCurrencyName,
      conversionRates: conversionRates ?? this.conversionRates,
    );
  }

  @override
  List<Object> get props => [status, ammount, isValid, showMenu, selectedCurrencyCode, selectedCurrencyName, conversionRates];
}
