import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:forms_app/presentation/blocs/counter-bloc/counter_bloc.dart';

class BlocCounterScreen extends StatelessWidget {
  const BlocCounterScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: ( _ ) => CounterBloc(),
      child: const BlocCounterView()
    );
  }

}


class BlocCounterView extends StatelessWidget {
  const BlocCounterView({
    super.key,
  });

  //FUNCIO
  void increaseCounterBy( BuildContext context, [int value=1] ){
    //OPCIO 1: ATACANT ALS EVENTS DEL GESTOR
    // context.read<CounterBloc>()
    //   .add(CounterIncreasedEvent(value));

    //OPCIO 2: ATACANT LES FUNCIONS QUE ENCAPSULEN ELS EVENTS
    context.read<CounterBloc>().increaseBy(value);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: context.select( (CounterBloc counterBloc){
          return Text('Bloc Counter: ${ counterBloc.state.transactionCount }');
        },),
        actions: [
          //OPCIO 1 ATACANT AL EVENT
          // IconButton(onPressed: ()=> context.read<CounterBloc>().add(ResetCounterEvent()), 
          //OPCIO 2 ATACANT LA FUNCIO EXPOSADA
          IconButton(
            onPressed: ()=> context.read<CounterBloc>().resetCounter(), 
            icon: const Icon( Icons.refresh_outlined)
          )
        ],
      ),
      body: Center(
        //1ª FORMA DE FER SERVIR EL PROVIDER BLOC
        child: context.select(
          (CounterBloc counterBloc) => Text('Counter value: ${ counterBloc.state.counter }'),
      )),
      floatingActionButton: Column(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          FloatingActionButton(
            heroTag: '1',
            child: const Text('+3'),
            onPressed: ()=> increaseCounterBy(context,3)
          ),
          const SizedBox(height: 15,),
          FloatingActionButton(
            heroTag: '2',
            child: const Text('+2'),
            onPressed: () => increaseCounterBy(context,2)
          ),
          const SizedBox(height: 15,),
          FloatingActionButton(
            heroTag: '3',
            child: const Text('+1'),  
            onPressed: ()=>increaseCounterBy(context)
          )
        ],
      ),
    );
  }
}