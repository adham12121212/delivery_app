part of 'order_cubit.dart';

@immutable
sealed class OrderState {}

final class OrderInitial extends OrderState {}

final class LoadingOrder extends OrderState{}

final class LoadedOrder extends OrderState{
  final List<OrderModel> order;
  LoadedOrder({required this.order});
}

final class ErrorOrder extends OrderState{
  final String message;
  ErrorOrder({required this.message});
}