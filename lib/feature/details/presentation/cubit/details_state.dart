part of 'details_cubit.dart';

@immutable
class DetailsState {
  final int quantity;
  final double totalPrice;
  final double unitPrice;

  const DetailsState({
    required this.quantity,
    required this.totalPrice,
    required this.unitPrice,
  });
}