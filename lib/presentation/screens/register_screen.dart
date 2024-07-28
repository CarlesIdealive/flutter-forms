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

class _RegisterForm extends StatefulWidget {
  const _RegisterForm();

  //ESTO ES EL ESTADO DEL STATEFUL
  @override
  State<_RegisterForm> createState() => _RegisterFormState();
}

class _RegisterFormState extends State<_RegisterForm> {
  //Creamos el GlobalKey
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    final registerCubit = context.watch<RegisterCubit>();
    return Form(
      key: _formKey,  //Enlazamos el FORM a traves del GlobalKey
      child: Column(
        children: [
          CustomTextFormField(
            label: 'Nombre de usuario' ,
            icon: const Icon( Icons.supervised_user_circle_outlined),
            // Si solo queremos que se redibuje cuando cambie
            // onChanged: registerCubit.usernameChanged,
            onChanged: (value) {
              registerCubit.usernameChanged(value);
              //Aqui valida cade vez que haya un cambio en el input
              _formKey.currentState?.validate();
            },
            validator: (value) {
              if (value == null || value.isEmpty) return 'Campo requerido';
              if (value.trim().isEmpty) return 'Campo requerido';
              if (value.length < 6) return 'La longitud minima del campo es de 6 caracteres'; 

              return null;
            },
          ),
          const SizedBox(height: 10,),

          CustomTextFormField(
            label: 'Correo electronico',
            onChanged: (value) {
              registerCubit.emailChanged(value);
              _formKey.currentState!.validate();
            },
            validator: (value) {
              if (value == null || value.isEmpty) return 'Campo requerido';
              if (value.trim().isEmpty) return 'Campo requerido';
              final emailRegExp = RegExp(
                r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$',
              );
              if ( !emailRegExp.hasMatch(value) ) return 'No tiene formato de correo electronico';

              return null;
            },

          ),
          const SizedBox(height: 20),

          CustomTextFormField(
            label: 'Contraseña',
            onChanged: (value) {
              registerCubit.passwordChanged(value);
              _formKey.currentState!.validate();
            },
            obscure: true,
            validator: (value) {
              if (value == null || value.isEmpty) return 'Campo requerido';
              if (value.trim().isEmpty) return 'Campo requerido';
              if (value.length < 6) return 'La longitud minima del campo es de 6 caracteres'; 

              return null;
            },


          ),
          const SizedBox(height: 20),

          FilledButton.tonalIcon(
            onPressed: (){
              final isValid = _formKey.currentState!.validate();
              if (!isValid) return;
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