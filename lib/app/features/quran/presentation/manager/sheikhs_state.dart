part of 'sheikhs_cubit.dart';

abstract class SheikhsState {}

class SheikhsInitial extends SheikhsState {}

class SheikhsLoading extends SheikhsState {}

class SheikhsLoaded extends SheikhsState {
  final List<SheikhModel> sheikhs;
  SheikhsLoaded(this.sheikhs);
}

class SheikhsError extends SheikhsState {
  final String message;
  SheikhsError(this.message);
}
