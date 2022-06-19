import 'dart:async';

import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'connectivity_event.dart';
part 'connectivity_state.dart';

class ConnectivityBloc extends Bloc<ConnectivityEvent, ConnectivityState> {
  StreamSubscription? subscription;

  ConnectivityBloc() : super(ConnectivityInitialState()) {
    on<OnConnectivityEvent>((event, emit) => emit(ConnectivitySuccessState()));
    on<OnNotConnectivityEvent>((event, emit) => emit(ConnectivityFailureState()));

    subscription = Connectivity()
        .onConnectivityChanged
        .listen((ConnectivityResult result) {
      if (result == ConnectivityResult.mobile ||
          result == ConnectivityResult.wifi) {
        add(OnConnectivityEvent());
      } else {
        add(OnNotConnectivityEvent());
      }
    });
  }
  @override
  Future<void> close() {
    subscription?.cancel();
    return super.close();
  }
}