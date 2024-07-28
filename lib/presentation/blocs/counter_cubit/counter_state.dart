part of 'counter_cubit.dart';

class CounterState extends Equatable {

  final int counter;
  final int transactionCount;

  const CounterState({
    required this.counter, 
    required this.transactionCount
  });

  //Emitir un nuevo estado (una copia de este estado)
  copyWith({
    int? counter,
    int? transactionCount
  }) => CounterState(
    counter: counter ?? this.counter, 
    transactionCount: transactionCount ?? this.transactionCount,
  );
  
  @override
  //Si dos objetos tienen counter y transactionCount iguales son iguales 
  //en caso contrario son distintos.
  List<Object> get props => [counter, transactionCount];

}
