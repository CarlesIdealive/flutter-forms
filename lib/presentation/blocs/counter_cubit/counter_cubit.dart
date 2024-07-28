import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'counter_state.dart';

//MANEJADOR DEL STATE
class CounterCubit extends Cubit<CounterState> {
  CounterCubit() : super( const CounterState(
    counter: 5,
    transactionCount: 0
  ));

  //PROPIEDADES Y METODOS QUE NO ESTAN AMARRADAS AL ESTADO / STATE
  //
  //
  void increaseBy(int value)
  {
    //No se puede hacer porque el estado es IMMUTABLE
    // state.counter ++;

    //Se puede hacer de esta manera
    // emit(CounterState(
    //   counter: state.counter + value,
    //   transactionCount: state.transactionCount + 1
    // ));

    //Definitivamente
    emit(state.copyWith(
      counter: state.counter + value,
      transactionCount: state.transactionCount + 1,
    ));

  }

  void reset()
  {
    emit(state.copyWith(
      counter: 0,
    ));
  }


}
