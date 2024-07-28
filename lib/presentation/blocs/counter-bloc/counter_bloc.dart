import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';

part 'counter_event.dart';
part 'counter_state.dart';

class CounterBloc extends Bloc<CounterEvent, CounterState> {

  CounterBloc() : super(const CounterState( counter: 10 )) {  //Counter no cal
    //Aquestes dos handlers dels events son equivalents
    // on<CounterIncreased>( (event, emit) => _onCounterIncreased(event, emit));
    on<CounterIncreasedEvent>(_onCounterIncreased);
    on<ResetCounterEvent>(_onResetCounter);


  }


  void _onCounterIncreased( CounterIncreasedEvent event, Emitter<CounterState> emit ) {
      emit(state.copyWith(
        counter: state.counter + event.value,  //El Evento tiene el valor
        transactionCount: state.transactionCount + 1
      ));
  }


  void _onResetCounter( ResetCounterEvent event, Emitter<CounterState> emit){
    emit(state.copyWith(
      counter: 0
    ));
  }


  //OPCIONAL - NO CRIDEM ELS EVENTS DESDE FORA - CENTRALITZEM AQUI AMB FUNCIONS QUE EXPOSEM
  void increaseBy( [int value = 1]){
    add(CounterIncreasedEvent(value));
  }

  void resetCounter(){
    add(ResetCounterEvent());
  }


}
