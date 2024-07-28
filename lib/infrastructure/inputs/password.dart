import 'package:formz/formz.dart';

// Define input validation errors to use it in handling part
enum PasswordError { empty, length }

// Extend FormzInput and provide the input type and error type.
class Password extends FormzInput<String, PasswordError> {


  // Call super.pure to represent an unmodified form input.
  const Password.pure() : super.pure('');

  // Call super.dirty to represent a modified form input.
  const Password.dirty( String value ) : super.dirty(value);

  //Getter para los errores
  String? get errorMEssage {
    if ( isValid || isPure ) return null;

    if ( displayError == PasswordError.empty ) return 'El campo es requerido';
    if ( displayError == PasswordError.length ) return 'Tamaño minimo 6 caracteres';

    return null;
  }


  // Override validator to handle validating a given input value.
  @override
  PasswordError? validator(String value) {
    if (value.isEmpty || value.trim().isEmpty ) return PasswordError.empty;
    if (value.length < 6 ) return PasswordError.length;

    //Si OK
    return null;
  }
}