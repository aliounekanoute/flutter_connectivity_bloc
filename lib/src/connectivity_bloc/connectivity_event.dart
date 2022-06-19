part of 'connectivity_bloc.dart';

@immutable
abstract class ConnectivityEvent {}

class OnConnectivityEvent extends ConnectivityEvent{}

class OnNotConnectivityEvent extends ConnectivityEvent{}
