import '../../data/model/resturant_model.dart';

abstract class RestaurantRepo{
  Future<List<ResturantModel>> getResturant({String? category});
}