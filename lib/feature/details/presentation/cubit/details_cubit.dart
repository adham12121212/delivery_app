import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

part 'details_state.dart';

class DetailsCubit extends Cubit<DetailsState> {
  DetailsCubit(double price)
      : super(DetailsState(quantity: 1, totalPrice: price, price: price));

  void increment() {
    final current = state;
    emit(current.copyWith(
        quantity: current.quantity + 1,
        totalPrice: (current.quantity + 1) * current.price));
  }

  void decrement() {
    final current = state;
    if (current.quantity > 1) {
      emit(current.copyWith(
          quantity: current.quantity - 1,
          totalPrice: (current.quantity - 1) * current.price));
    }
  }
}