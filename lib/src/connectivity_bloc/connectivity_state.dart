part of 'connectivity_bloc.dart';

/// The base abstract class for different connectivity states.
/// It is marked as immutable, indicating that its subclasses should also be immutable.
@immutable
abstract class ConnectivityState {}

/// Represents the initial connectivity state.
class ConnectivityInitialState extends ConnectivityState {}

/// Represents the successful connectivity state.
class ConnectivitySuccessState extends ConnectivityState {}

/// Represents the failure connectivity state.
class ConnectivityFailureState extends ConnectivityState {}
