
import 'package:delivery_app/feature/home/data/model/offer_model.dart';
import 'package:delivery_app/feature/restaurant/data/model/resturant_model.dart';

abstract class HomeRepo{
  Future<List<OfferModel>> getOffers();
}