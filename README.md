# Connectivity Bloc

Connectivity Bloc allows to continuously check the connection state in an application.

## Installation

1. Add the latest version of package to your pubspec.yaml (and run ```dart pub get connectivity_bloc```):
```yaml
dependencies:
    connectivity_bloc: ^0.0.1
```

2. Import the package and use it in your Flutter App.

```dart
import 'package:connectivity_bloc/connectivity_bloc.dart';
```

## Usage

1. Create and provide the bloc to your widget using BlocProvider

___I suggest to provide it from the main child then all his children will access to the bloc object___

```dart
import 'package:flutter/material.dart';
import 'package:connectivity_bloc/connectivity_bloc.dart';

void main() => runApp(const MyApp());

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
        create: (context) => ConnectivityBloc(),
        child: MaterialApp(
          title: 'Connectivity Bloc Demo',
          theme: ThemeData(
            primarySwatch: Colors.blue,
          ),
          home: const MyHomePage(title: 'Connectivity Bloc Demo'),
        )
    );
  }
}
```


2. Using BlocBuilder to rebuild your widget when the states change.


```dart


class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key, required this.title}) : super(key: key);

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ConnectivityBloc, ConnectivityState>(
        builder: (context, state) => Scaffold(
          appBar: AppBar(
            title: Text(widget.title),
          ),
          backgroundColor: Colors.white,
          body: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Text(
                  (state is ConnectivityFailureState) ? 'No internet connexion' : 'Internet connexion is ok',
                  style: TextStyle(
                      color: (state is ConnectivityFailureState) ? Colors.red : Colors.green
                  ),
                ),
              ],
            ),
          ),
        )
    );
  }
}
```

Here are the different stats that can occur:

- ConnectivityInitialState : this is the initial state
- ConnectivitySuccessState : this is the state when the connexion is ok
- ConnectivityFailureState : this is the state when there is no connexion
