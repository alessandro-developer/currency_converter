import 'package:formz/formz.dart';

/// AMMOUNT VALIDATOR:
enum AmmountValidationError { invalid }

class Ammount extends FormzInput<String, AmmountValidationError> {
  const Ammount.pure() : super.pure('');
  const Ammount.dirty([super.value = '']) : super.dirty();

  static final RegExp _ammount = RegExp(r'^\s*\d+(\s*\d+)*\s*$');

  @override
  AmmountValidationError? validator(String? value) {
    return (value == null || value.isEmpty || !_ammount.hasMatch(value)) ? AmmountValidationError.invalid : null;
  }
}
