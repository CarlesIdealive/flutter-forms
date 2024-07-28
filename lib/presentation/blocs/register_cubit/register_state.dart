part of 'register_cubit.dart';


enum FromStatus { invalid, valid, validating, posting }

class RegisterFormState extends Equatable {

  final FromStatus formStatus;
  final bool isValid;
  final UserName username;
  final Email email;
  final Password password;

  RegisterFormState({
    this.formStatus = FromStatus.invalid, 
    this.isValid = false,
    this.username = const UserName.pure(),
    this.email = const Email.pure(),
    this.password = const Password.pure()
  });

  //Emitir un nuevo estado (una copia de este estado)
  RegisterFormState copyWith({
    FromStatus? formStatus,
    bool? isValid,
    UserName? username,
    Email? email,
    Password? password,
  }) => RegisterFormState(
    formStatus : formStatus ?? this.formStatus,
    isValid: isValid ?? this.isValid,
    username : username ?? this.username,
    email : email ?? this.email,
    password : password ?? this.password
  );

  @override
  List<Object> get props => [ formStatus, email, username, password ];
}
