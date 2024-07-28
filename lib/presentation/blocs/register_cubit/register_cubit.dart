import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:formz/formz.dart';
import 'package:forms_app/infrastructure/inputs/inputs.dart';

part 'register_state.dart';

class RegisterCubit extends Cubit<RegisterFormState> {
  RegisterCubit() : super(RegisterFormState());


  //METODOS - Estos metodos se llaman desde los Inputs para actualizar el estado del Cubit
  void onSubmit() {
    emit(
      state.copyWith(
        formStatus: FromStatus.validating,
        //Al pulsar el boton ensuciamos el campo para que salta el error si existe
        username: UserName.dirty(state.username.value),
        password: Password.dirty(state.password.value),
        email: Email.dirty(state.email.value),

        isValid: Formz.validate([
          state.username, 
          state.password,
          state.email
        ])
      )
    );


    print('Cubit Submit: $state');
  }

  void usernameChanged( String value ){
    //Crea una nueva instancia con el nuevo valor.
    final username = UserName.dirty(value);
    emit(
      state.copyWith(
        username: username,
        isValid: Formz.validate([username, state.password, state.email])
      )
    );
  }
  void emailChanged( String value ){
    final email = Email.dirty(value);
    emit(
      state.copyWith(
        email: email,
        isValid: Formz.validate([email, state.username, state.password])
      )
    );
  }
  void passwordChanged( String value ){
    final password = Password.dirty(value);
    emit(
      state.copyWith(
        password: password,
        isValid: Formz.validate([password, state.username, state.email])
      )
    );
  }


}
