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
  /// Subscription to the connectivity changes stream.
  /// Emits lists of `ConnectivityResult` whenever the network status changes.
  StreamSubscription<List<ConnectivityResult>>? subscription;

  /// Constructs a new instance of the `ConnectivityBloc`.
  ///
  /// Initializes the state to [ConnectivityInitialState], sets up
  /// event handlers for connectivity success/failure, and
  /// subscribes to the connectivity change stream.
  ConnectivityBloc() : super(ConnectivityInitialState()) {
    // When a successful connectivity event is received,
    // transition to ConnectivitySuccessState.
    on<OnConnectivityEvent>(
      (event, emit) => emit(ConnectivitySuccessState()),
    );

    // When a connectivity failure event is received,
    // transition to ConnectivityFailureState.
    on<OnNotConnectivityEvent>(
      (event, emit) => emit(ConnectivityFailureState()),
    );

    // Listen to the platform connectivity stream.
    subscription =
        Connectivity().onConnectivityChanged.listen(_handleConnectivityChange);
  }

  /// Internal handler for processing connectivity change notifications.
  ///
  /// - `results`: a list of `ConnectivityResult` values emitted by the plugin.
  ///
  /// Checks if any connection type besides `none` is available. If so,
  /// performs a lightweight HTTP GET to Google to verify real internet access.
  /// Depending on the outcome, dispatches either [OnConnectivityEvent]
  /// or [OnNotConnectivityEvent].
  Future<void> _handleConnectivityChange(
      List<ConnectivityResult> results) async {
    final hasNetwork = results.any((r) => r != ConnectivityResult.none);

    if (hasNetwork) {
      try {
        final response = await http.get(
          Uri.parse('https://www.google.com'),
        );
        if (response.statusCode == 200) {
          add(OnConnectivityEvent());
        } else {
          add(OnNotConnectivityEvent());
        }
      } on SocketException {
        add(OnNotConnectivityEvent());
      }
    } else {
      add(OnNotConnectivityEvent());
    }
  }

  /// Cancels the connectivity subscription and closes the BLoC.
  ///
  /// Must be called to avoid memory leaks when the BLoC is disposed.
  @override
  Future<void> close() {
    subscription?.cancel();
    return super.close();
  }
}
