import '../../data/model/order_model.dart';

abstract class RepoOrder {
   Future<List<OrderModel>> getOrder(String userId);
   Future<void> addOrder(String userId, OrderModel order);}