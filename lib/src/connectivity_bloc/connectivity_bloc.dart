import 'dart:async';
import 'dart:io';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:http/http.dart' as http;
part 'connectivity_event.dart';
part 'connectivity_state.dart';

/// A BLoC (Business Logic Component) responsible for managing connectivity events and states.
/// It extends the `Bloc` class, with `ConnectivityEvent` as the event type and `ConnectivityState` as the state type.
class ConnectivityBloc extends Bloc<ConnectivityEvent, ConnectivityState> {
  StreamSubscription? subscription;

  /// Constructs a new instance of the `ConnectivityBloc`.
  /// It initializes the state to `ConnectivityInitialState`.
  ConnectivityBloc() : super(ConnectivityInitialState()) {
    // Handle the 'OnConnectivityEvent' by emitting a `ConnectivitySuccessState`.
    on<OnConnectivityEvent>((event, emit) => emit(ConnectivitySuccessState()));

    // Handle the 'OnNotConnectivityEvent' by emitting a `ConnectivityFailureState`.
    on<OnNotConnectivityEvent>((event, emit) => emit(ConnectivityFailureState()));

    // Subscribe to connectivity changes using the `Connectivity` plugin.
    subscription = Connectivity()
        .onConnectivityChanged
        .listen((ConnectivityResult result) async {
      if (result != ConnectivityResult.none) {
        // If the connectivity result is none , verify if device really have access to network.
        try
        {
          final response = await http.get(Uri.parse('https://www.google.com'));
          if(response.statusCode==200)
          {
            add(OnConnectivityEvent());
          }
        }
        on SocketException catch(_)
        {
          add(OnNotConnectivityEvent());
        }

      } else {
        // Otherwise, add an 'OnNotConnectivityEvent'.
        add(OnNotConnectivityEvent());
      }
    });
  }

  /// Closes the BLoC and performs necessary cleanup.
  @override
  Future<void> close() {
    subscription?.cancel(); // Cancel the subscription to stop listening for connectivity changes.
    return super.close(); // Close the BLoC and release any resources.
  }
}
