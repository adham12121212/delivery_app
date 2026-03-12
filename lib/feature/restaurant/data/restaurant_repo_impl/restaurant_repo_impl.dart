
import 'package:delivery_app/feature/restaurant/domain/restaurant_repo/restaurant_reop.dart';
import 'package:flutter/cupertino.dart';

import '../../../../core/erorr/api_exception.dart';
import '../../../../core/service/firestore_data.dart';
import '../model/resturant_model.dart';

class RestaurantRepoImpl implements RestaurantRepo{
  final FireStoreData fireStoreData;
  RestaurantRepoImpl(this.fireStoreData);
  @override
  Future<List<ResturantModel>> getResturant({String? category}) async {
    try {
      return await fireStoreData.getResturant(category: category);
    } on ApiException {
      rethrow;
    } catch (e) {
      throw ApiException('حدث خطأ غير متوقع');
    }
  }

}