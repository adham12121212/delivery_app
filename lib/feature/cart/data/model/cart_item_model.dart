import 'package:meta/meta.dart';

@immutable
class CartItemModel {
  final String id;
  final String name;
  final String image;
  final double price;
  final int quantity;
  final double totalPrice;

  const CartItemModel({
    required this.id,
    required this.name,
    required this.image,
    required this.price,
    required this.quantity,
    required this.totalPrice,
  });

  CartItemModel copyWith({
    String? id,
    String? name,
    String? image,
    double? price,
    int? quantity,
    double? totalPrice,
  }) {
    return CartItemModel(
      id: id ?? this.id,
      name: name ?? this.name,
      image: image ?? this.image,
      price: price ?? this.price,
      quantity: quantity ?? this.quantity,
      totalPrice: totalPrice ?? this.totalPrice,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'name': name,
      'image': image,
      'price': price,
      'quantity': quantity,
      'totalPrice': totalPrice,
    };
  }

  factory CartItemModel.fromMap(Map<String, dynamic> map) {
    return CartItemModel(
      id: map['id'] ?? '',
      name: map['name'] ?? '',
      image: map['image'] ?? '',
      price: (map['price'] ?? 0).toDouble(),
      quantity: map['quantity'] ?? 0,
      totalPrice: (map['totalPrice'] ?? 0).toDouble(),
    );
  }
}