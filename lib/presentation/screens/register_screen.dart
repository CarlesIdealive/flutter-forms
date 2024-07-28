import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:forms_app/presentation/blocs/register_cubit/register_cubit.dart';
import 'package:forms_app/presentation/widgets/widgets.dart';

class RegisterScreen extends StatelessWidget {
  const RegisterScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Nuevo Usuario'),
      ),
      body: BlocProvider(
        create: (context) => RegisterCubit(),
        child: const _RegisterView(),
        ),
    );
  }

}

class _RegisterView extends StatelessWidget {
  const _RegisterView();

  @override
  Widget build(BuildContext context) {
    return const SafeArea(
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: 10),
        child: SingleChildScrollView(
          child: Column(
            // mainAxisAlignment: MainAxisAlignment.end,
            children: [
              FlutterLogo(size: 100),
              _RegisterForm(),
              SizedBox(height: 20)
            ],
          ),
        ),
      ),
    );
  }
}

class _RegisterForm extends StatelessWidget {
  const _RegisterForm();

  //ESTO ES EL ESTADO DEL STATEFUL
  //Creamos el GlobalKey
  @override
  Widget build(BuildContext context) {
    final registerCubit = context.watch<RegisterCubit>();
    final username = registerCubit.state.username;
    final password = registerCubit.state.password;
    final email = registerCubit.state.email;


    return Form(
      // key: _formKey,  //Enlazamos el FORM a traves del GlobalKey
      child: Column(
        children: [
          CustomTextFormField(
            label: 'Nombre de usuario' ,
            icon: const Icon( Icons.supervised_user_circle_outlined),
            onChanged:  registerCubit.usernameChanged,
            errorMessage: username.errorMessage
          ),
          const SizedBox(height: 10,),

          CustomTextFormField(
            label: 'Correo electronico',
            onChanged:  registerCubit.emailChanged,
            errorMessage: email.errorMessage,
          ),
 
          const SizedBox(height: 20),

          CustomTextFormField(
            label: 'Contraseña',
            onChanged:  registerCubit.passwordChanged,
            errorMessage: password.errorMEssage,
            obscure: true,
          ),

          const SizedBox(height: 20),

          FilledButton.tonalIcon(
            onPressed: (){

              registerCubit.onSubmit();
            }, 
            icon: const Icon( Icons.save ),
            label: const Text('Crear usuario'),
          ),
        ],
      ),

    );
  }
}