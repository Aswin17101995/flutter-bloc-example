import 'package:bloc_sample/bloc/ThemeBloc/theme_event.dart';
import 'package:bloc_sample/bloc/ThemeBloc/theme_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ThemeBloc extends Bloc<ThemeEvent,ThemeState>{
  ThemeBloc(): super(ThemeState(false)){
    on<Toggle>((event,emit){
      emit(ThemeState(!state.isDark));
    });
  }
}