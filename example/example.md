# 📡 Flutter Connectivity Bloc Example

This example demonstrates how to use the [`flutter_connectivity_bloc`](https://pub.dev/packages/connectivity_bloc) package to monitor internet connectivity in a Flutter application using the BLoC pattern.

---

## 🧩 Dependencies

Add the following to your `pubspec.yaml`:

```yaml
dependencies:
  flutter:
    sdk: flutter
  flutter_bloc: ^8.1.3
  connectivity_bloc: ^latest
```

⚠️ Replace ^latest with the latest version available on pub.dev.

⸻

📱 Main Application Code
```dart
import 'package:connectivity_bloc/connectivity_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

void main() => runApp(const MyApp());

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildCContext context) {
    return BlocProvider(
      create: (context) => ConnectivityBloc(),
      child: MaterialApp(
        title: 'Connectivity Bloc Demo',
        theme: ThemeData(primarySwatch: Colors.blue),
        home: const MyHomePage(title: 'Connectivity Bloc Demo'),
      ),
    );
  }
}
```


⸻

🏠 Home Page UI
```dart
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
        appBar: AppBar(title: Text(widget.title)),
        backgroundColor: Colors.white,
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Text(
                (state is ConnectivityFailureState)
                    ? 'No internet connection'
                    : 'Internet connection is ok',
                style: TextStyle(
                  color: (state is ConnectivityFailureState)
                      ? Colors.red
                      : Colors.green,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
```


⸻

📊 Explanation

- ConnectivityBloc is initialized and provided at the top level of the app using BlocProvider.
- BlocBuilder listens for state changes in the ConnectivityBloc.
- Depending on the current state:
    - ConnectivityFailureState: Displays “No internet connection” in red.
    - Otherwise: Displays “Internet connection is ok” in green.

⸻

✅ Output

The app displays a message indicating the network status, updated in real-time as the connectivity changes.

🟢 Internet connection is ok

🔴 No internet connection
