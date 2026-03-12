part of 'cart_cubit.dart';

@immutable
abstract class CartState {}

class CartInitial extends CartState {}

class CartLoaded extends CartState {
  final List<CartItemModel> items;

  CartLoaded({required this.items});

  double get subtotal => items.fold(0, (sum, item) => sum + item.totalPrice);
  double get total => subtotal + 25;
}

class CartError extends CartState {
  final String message;
  CartError(this.message);
}