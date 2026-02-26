
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:delivery_app/feature/restaurant/data/model/resturant_model.dart';

import '../../feature/home/data/model/offer_model.dart';
import '../erorr/api_exception.dart';

class FireStoreData{

  Future<List<OfferModel>> getOffer() async {
    final snapshot =
    await FirebaseFirestore.instance.collection('offers').get();

    return snapshot.docs
        .map((doc) => OfferModel.fromJson(doc.data(), doc.id))
        .toList();
  }

  Future<List<ResturantModel>> getResturant({String? category}) async {

      final ref = FirebaseFirestore.instance.collection('restaurant');

      final query = (category == null || category.isEmpty)
          ? ref
          : ref.where('category', isEqualTo: category);

      final snap = await query.get();

      return snap.docs
          .map((doc) => ResturantModel.fromJson(doc.data()))
          .toList();

  }

}