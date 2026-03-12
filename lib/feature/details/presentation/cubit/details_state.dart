part of 'details_cubit.dart';

class DetailsState {
  final int quantity;
  final double totalPrice;
  final double price;

  DetailsState({required this.quantity, required this.totalPrice, required this.price});

  DetailsState copyWith({int? quantity, double? totalPrice, double? price}) {
    return DetailsState(
      quantity: quantity ?? this.quantity,
      totalPrice: totalPrice ?? this.totalPrice,
      price: price ?? this.price,
    );
  }
}