import 'package:connectivity_bloc/connectivity_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

void main() => runApp(const MyApp());

class MyApp extends StatelessWidget {
  const MyApp({super.key});

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

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

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
