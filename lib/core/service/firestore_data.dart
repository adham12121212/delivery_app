
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:delivery_app/feature/Auth/data/model/user_model.dart';
import 'package:delivery_app/feature/restaurant/data/model/resturant_model.dart';

import '../../feature/home/data/model/offer_model.dart';
import '../../feature/menu/data/model/menu_model.dart';

class FireStoreData{

  Future<List<OfferModel>> getOffer() async {
    final snapshot =
    await FirebaseFirestore.instance.collection('offers').get();

    return snapshot.docs
        .map((doc) => OfferModel.fromJson(doc.data(), doc.id))
        .toList();
  }

  Future<List<ResturantModel>> getResturant({String? category}) async {
    Query<Map<String, dynamic>> query =
    FirebaseFirestore.instance.collection('restaurant');

    if (category != null && category.trim().isNotEmpty) {
      query = query.where('category', isEqualTo: category.trim());
    }

    final snap = await query.get();

    return snap.docs
        .map((doc) => ResturantModel.fromJson(doc.data(), doc.id))
        .toList();
  }

  Future<List<MenuModel>> getMenu(String restaurantId) async {
    final snapshot = await FirebaseFirestore.instance
        .collection('restaurant')
        .doc(restaurantId)
        .collection('menu')
        .get();

    return snapshot.docs
        .map((doc) => MenuModel.fromJson(doc.data(), doc.id))
        .toList();
  }


  Future<void> addData({
    required String path,
    required Map<String, dynamic> data,
    String? documentId,
  }) async {
    if (documentId != null) {
      await FirebaseFirestore.instance
          .collection(path)
          .doc(documentId)
          .set(data);
    } else {
      await FirebaseFirestore.instance
          .collection(path)
          .add(data);
    }
  }
}