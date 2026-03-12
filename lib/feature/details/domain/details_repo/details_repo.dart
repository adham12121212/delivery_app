

import '../../../menu/data/model/menu_model.dart';

abstract class DetailsRepo {
  Future<void> addToCart({
    required String uid,
    required MenuModel menu,
    required int quantity,
    required double totalPrice,
  });
}