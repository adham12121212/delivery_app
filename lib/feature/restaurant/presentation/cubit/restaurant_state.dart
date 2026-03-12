part of 'restaurant_cubit.dart';

@immutable
sealed class RestaurantState {}

final class RestaurantInitial extends RestaurantState {}

final class LoadingResturant extends RestaurantState{}

final class SuccessResturant extends RestaurantState{
  final List<ResturantModel> resturant;
  SuccessResturant(this.resturant);
}

final class ErrorResturant extends RestaurantState{
  final String message;
  ErrorResturant(this.message);
}