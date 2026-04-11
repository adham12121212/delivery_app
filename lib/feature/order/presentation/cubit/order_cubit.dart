import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

import '../../data/model/order_model.dart';
import '../../domain/repo_order/repo_order.dart';

part 'order_state.dart';

class OrderCubit extends Cubit<OrderState> {
  OrderCubit(this.repoOrder) : super(OrderInitial());

  final RepoOrder repoOrder;

  Future<void> getOrder(String userId)async{
    emit(LoadingOrder());
    try{
      final data = await repoOrder.getOrder(userId);
      emit(LoadedOrder(order: data));
    }on Exception catch (e) {
      emit(ErrorOrder(message: e.toString()));
    }
  }

  Future<void> addOrder(String userId, OrderModel order) async {
    try {
      await repoOrder.addOrder(userId, order);
      await getOrder(userId);

    } catch (e) {
      emit(ErrorOrder(message: e.toString()));
    }
  }
}
