import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

part 'details_state.dart';

class DetailsCubit extends Cubit<DetailsState> {
  DetailsCubit(double price) : super(DetailsState(quantity: 1, totalPrice: price, unitPrice: price));

  /// زيادة الكمية
  void increment() {
    emit(DetailsState(
      quantity: state.quantity + 1,
      unitPrice: state.unitPrice,
      totalPrice: state.unitPrice * (state.quantity + 1),
    ));
  }

  /// تقليل الكمية
  void decrement() {
    if (state.quantity > 1) {
      emit(DetailsState(
        quantity: state.quantity - 1,
        unitPrice: state.unitPrice,
        totalPrice: state.unitPrice * (state.quantity - 1),
      ));
    }
  }
}