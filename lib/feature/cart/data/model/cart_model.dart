import 'cart_item_model.dart';

class CartModel {
  final List<CartItemModel> items;

  const CartModel({this.items = const []});

  double get subtotal => items.fold(0, (sum, item) => sum + item.totalPrice);

  double get total => subtotal + deliveryFee;

  int get totalItems => items.fold(0, (sum, item) => sum + item.quantity);

  CartModel copyWith({List<CartItemModel>? items}) {
    return CartModel(items: items ?? this.items);
  }

  static const double deliveryFee = 25;
}