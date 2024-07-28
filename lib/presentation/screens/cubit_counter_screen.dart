import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:forms_app/presentation/blocs/counter_cubit/counter_cubit.dart';

class CubitCounterScreen extends StatelessWidget {
  const CubitCounterScreen({super.key});

  @override
  Widget build(BuildContext context) {
    //Envolvemos todos los widgets de la pantalla con el Provider
    return BlocProvider(
        //PROBLEMA: SI QUEREMOS 2 INSTANCIAS DE COUNTERCUBIT PORQUE SE HACE REFERENCIA SIEMPRE A LA 1 INSTANCIA
        create: (_) => CounterCubit(), 
        child: const _CubitCounterView());
  }
}

class _CubitCounterView extends StatelessWidget {
  const _CubitCounterView();

  void increaseCounterBy( BuildContext context, [int value = 1] ){
    if (value >0) {
      context.read<CounterCubit>().increaseBy(value);
    }
  }


  @override
  Widget build(BuildContext context) {
    //2ª FORMA de trabajar con CUBIT: tipo Provider watch(),
    //Cada vez que el state cambie (Devuelve CounteerState)
    // final counterState = context.watch<CounterCubit>().state;

    return Scaffold(
      appBar: AppBar(
        //3ª OPCION DE TREBALLAR ESPECIFICAMENT EN UN WIDGET AMB EL CUBIT SI NO VOLEM 2 FORMA GLOBAL
        //ES IDENTIC A LA OPCIO 1 PERO SIMPLIFICADA (BLOCBUILDER)
        title: context.select((CounterCubit value) {
          return Text('Cubit Counter: ${ value.state.transactionCount }');
        },),
        // title: Text('Cubit Counter: ${ counterState.transactionCount }'),
        actions: [
          IconButton(
            onPressed: () => context.read<CounterCubit>().reset(), 
            icon: const Icon(Icons.refresh_outlined)
          )
        ],
      ),
      body: Center(
        //1! FORMA DE TRABAJAR - SOLAMENTE EN UN WIDGET CON EL BLOCBUIDER --Mucho codigo.
        child: BlocBuilder<CounterCubit, CounterState>(
          // buildWhen: (previous, current) => current.counter != previous.counter,
          builder: (context, state) {
            return Text('Counter value: ${state.counter}');
          },
        ),
      ),
      floatingActionButton: Column(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          FloatingActionButton(
              heroTag: '1', child: const Text('+3'), onPressed: () => increaseCounterBy(context, 3) ),
          const SizedBox(
            height: 15,
          ),
          FloatingActionButton(
              heroTag: '2', child: const Text('+2'), onPressed: () => increaseCounterBy( context, 2) ),
          const SizedBox(
            height: 15,
          ),
          FloatingActionButton(
              heroTag: '3', child: const Text('+1'), onPressed: () => increaseCounterBy( context ) )
        ],
      ),
    );
  }
}
