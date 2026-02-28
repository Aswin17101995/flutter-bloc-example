

import 'package:bloc_sample/bloc/counter/counter_event.dart';
import 'package:bloc_sample/bloc/counter/counter_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class CounterBloc extends Bloc<CounterEvent,CounterState> {
  CounterBloc() : super(CounterState(0, null))
  {
    on<IncrementEvent> ((event, emit) {
      emit(CounterState(state.count + 1, null));
    });

    on<DecrementEvent> ((event,emit){
      if(state.count > 0){
        emit(CounterState(state.count - 1, null));
      }else{
        emit(CounterState(0, "Counter cannot be negative"));
      }
    });
  }


}