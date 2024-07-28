part of 'register_cubit.dart';


enum FromStatus { invalid, valid, validating, posting }

class RegisterFormState extends Equatable {

  final FromStatus formStatus;
  final String username;
  final String email;
  final String password;

  RegisterFormState({
    this.formStatus = FromStatus.invalid, 
    this.email = '',
    this.username = '',
    this.password = ''
  });

  //Emitir un nuevo estado (una copia de este estado)
  RegisterFormState copyWith({
    FromStatus? formStatus,
    String? username,
    String? email,
    String? password,
  }) => RegisterFormState(
    formStatus : formStatus ?? this.formStatus,
    username : username ?? this.username,
    email : email ?? this.email,
    password : password ?? this.password
  );

  @override
  List<Object> get props => [ formStatus, email, username, password ];
}
