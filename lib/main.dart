import 'package:bloc_sample/bloc/ThemeBloc/theme_state.dart';
import 'package:bloc_sample/bloc/counter/counter_event.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'bloc/ThemeBloc/theme_bloc.dart';
import 'bloc/ThemeBloc/theme_event.dart';
import 'bloc/counter/counter_bloc.dart';
import 'bloc/counter/counter_state.dart';

void main() {
  runApp(
   MultiBlocProvider(providers: [
     BlocProvider(create: (context)=> CounterBloc()),
     BlocProvider(create: (context){return ThemeBloc();})
   ],
       child: BlocBuilder<ThemeBloc,ThemeState>( builder : (context, themeState) {
          return MaterialApp(
            theme: themeState.isDark ? ThemeData.dark() : ThemeData.light(),
            home: MyApp(),
          );
       }
       ))
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocListener<CounterBloc, CounterState>(
      listener: (context, state) {
        if (state.errorMessage != null) {
          ScaffoldMessenger.of(
            context,
          ).showSnackBar(SnackBar(content: Text(state.errorMessage!)));
        }
      },
      child: Scaffold(
        appBar: AppBar(title: Text("Bloc Counter")),
        body: BlocBuilder<CounterBloc,CounterState>(builder: (context,state){
          return Center(
            child: Text(
              "Counter Value: ${state.count}",
              style: TextStyle(fontSize: 24),
            ),
          );
        }),
        floatingActionButton: Column(
          crossAxisAlignment: CrossAxisAlignment.end,
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            FloatingActionButton(
              onPressed: () {
                context.read<CounterBloc>().add(IncrementEvent());
              },
              child: Icon(Icons.add),
            ),
            SizedBox(height: 10),
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                FloatingActionButton(onPressed: (){
                  context.read<ThemeBloc>().add(Toggle());
                },
                child: BlocBuilder<ThemeBloc,ThemeState>(builder: (context,themeState) =>
                themeState.isDark ? Icon(Icons.dark_mode) : Icon(Icons.light_mode)
                ),
                ),
                SizedBox(width: 20,),
                FloatingActionButton(
                  onPressed: () {
                    context.read<CounterBloc>().add(DecrementEvent());
                  },
                  child: Icon(Icons.remove),
                ),
              ],
            )
          ],
        ),
      ),
    );
  }
}
