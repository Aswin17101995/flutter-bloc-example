# Flutter MultiBloc Example

This project demonstrates how to use **Multiple BLoCs in a Flutter application** using `flutter_bloc` and `MultiBlocProvider`.

The app contains two blocs:

* **CounterBloc** → Handles counter increment and decrement
* **ThemeBloc** → Toggles between light and dark theme

---

## Features

* Increment and decrement counter
* Prevent counter from going below zero
* Show error message using `BlocListener`
* Toggle application theme
* Use multiple blocs with `MultiBlocProvider`

---

## Packages Used

```yaml
dependencies:
  flutter_bloc: ^8.1.3
```

---

## Project Structure

```
lib/
│
├── bloc/
│   ├── counter/
│   │   ├── counter_bloc.dart
│   │   ├── counter_event.dart
│   │   └── counter_state.dart
│   │
│   └── themeBloc/
│       ├── theme_bloc.dart
│       └── theme_state.dart
│
├── main.dart
└── ui/
    └── counter_page.dart
```

---

## MultiBlocProvider Setup

`MultiBlocProvider` allows us to provide multiple blocs to the widget tree.

```dart
runApp(
  MultiBlocProvider(
    providers: [
      BlocProvider(
        create: (_) => CounterBloc(),
      ),
      BlocProvider(
        create: (_) => ThemeBloc(),
      ),
    ],
    child: MyApp(),
  ),
);
```

---

## Using BlocBuilder

`BlocBuilder` rebuilds the UI when the state changes.

```dart
BlocBuilder<CounterBloc, CounterState>(
  builder: (context, state) {
    return Text(
      "Counter Value: ${state.count}",
      style: TextStyle(fontSize: 24),
    );
  },
)
```

---

## Using BlocListener

`BlocListener` is used for side effects like showing snackbars, dialogs, or navigation.

```dart
BlocListener<CounterBloc, CounterState>(
  listener: (context, state) {
    if (state.errorMessage != null) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text(state.errorMessage!)),
      );
    }
  },
  child: YourWidget(),
)
```

---

## Triggering Events

Events are dispatched using `context.read()`.

```dart
context.read<CounterBloc>().add(IncrementEvent());
```

```dart
context.read<ThemeBloc>().add(Toggle());
```

---

## Execution Flow

```
User Action
     ↓
Event Added
     ↓
Bloc Processes Event
     ↓
New State Emitted
     ↓
UI Rebuilds via BlocBuilder
```

---

## Learning Goals

This project helps understand:

* BLoC architecture
* Event-driven state management
* MultiBlocProvider usage
* BlocBuilder vs BlocListener
* Managing multiple features with separate blocs

---

## Author

**Aswin**

Flutter Developer
