part of 'counter_bloc.dart';


//PARA EMITIR NUEVOS ESTADOS SE HACE EN BASE A EVENTOS QUE LOS RECIBE EL BLOC
//PERMITE DEFINIR QUE EVENTOS VA A RECIBIR
sealed class CounterEvent extends Equatable {
  const CounterEvent();

  @override
  List<Object> get props => [];
}


//NUEVO EVENTO
class CounterIncreasedEvent extends CounterEvent {
  final int value;

  const CounterIncreasedEvent( this.value );
}

//NUEVO EVENTO
class ResetCounterEvent extends CounterEvent {}