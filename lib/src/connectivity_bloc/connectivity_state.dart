part of 'connectivity_bloc.dart';

@immutable
abstract class ConnectivityState {}

class ConnectivityInitialState extends ConnectivityState {}

class ConnectivitySuccessState extends ConnectivityState {}

class ConnectivityFailureState extends ConnectivityState {}
