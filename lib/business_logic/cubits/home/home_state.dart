part of 'home_cubit.dart';

class HomeState extends Equatable {
  final Ammount ammount;
  final FormzSubmissionStatus status;
  final bool isValid;
  final bool showMenu;

  const HomeState({
    this.ammount = const Ammount.pure(),
    this.status = FormzSubmissionStatus.initial,
    this.isValid = false,
    this.showMenu = false,
  });

  HomeState copyWith({
    Ammount? ammount,
    FormzSubmissionStatus? status,
    bool? isValid,
    bool? showMenu,
  }) {
    return HomeState(
      ammount: ammount ?? this.ammount,
      status: status ?? this.status,
      isValid: isValid ?? this.isValid,
      showMenu: showMenu ?? this.showMenu,
    );
  }

  @override
  List<Object> get props => [ammount, status, isValid, showMenu];
}
