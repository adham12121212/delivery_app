
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:delivery_app/feature/Auth/data/model/user_model.dart';
import 'package:delivery_app/feature/cart/data/model/cart_item_model.dart';
import 'package:delivery_app/feature/restaurant/data/model/resturant_model.dart';
import '../../feature/home/data/model/offer_model.dart';
import '../../feature/menu/data/model/menu_model.dart';
import '../../feature/order/data/model/order_model.dart';

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
  Future<List<OrderModel>> getOrder(String userId) async {
    final snapshot = await FirebaseFirestore.instance
        .collection('orders')
        .doc(userId)
        .collection('order')
        .get();

    return snapshot.docs
        .map((doc) => OrderModel.fromJson(doc.data(), doc.id))
        .toList();
  }

  Future<void> addOrder(String userId, OrderModel order) async {
    await FirebaseFirestore.instance
        .collection('orders')
        .doc(userId)
        .collection('order')
        .add(order.toJson());
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












  final FirebaseFirestore _firestore = FirebaseFirestore.instance;


  Future<void> setDocument({
    required String collection,
    required String docId,
    required Map<String, dynamic> data,
    String? subCollection,
    String? subDocId,
  }) async {
    if (subCollection != null && subDocId != null) {
      await _firestore
          .collection(collection)
          .doc(docId)
          .collection(subCollection)
          .doc(subDocId)
          .set(data);
    } else {
      await _firestore
          .collection(collection)
          .doc(docId)
          .set(data);
    }
  }

  Future<Map<String, dynamic>?> getDocument({
    required String collection,
    required String docId,
    String? subCollection,
    String? subDocId,
  }) async {
    DocumentSnapshot doc;

    if (subCollection != null && subDocId != null) {
      doc = await _firestore
          .collection(collection)
          .doc(docId)
          .collection(subCollection)
          .doc(subDocId)
          .get();
    } else {
      doc = await _firestore
          .collection(collection)
          .doc(docId)
          .get();
    }

    return doc.exists ? doc.data() as Map<String, dynamic> : null;
  }

  Future<void> deleteDocument({
    required String collection,
    required String docId,
    String? subCollection,
    String? subDocId,
  }) async {
    if (subCollection != null && subDocId != null) {
      await _firestore
          .collection(collection)
          .doc(docId)
          .collection(subCollection)
          .doc(subDocId)
          .delete();
    } else {
      await _firestore
          .collection(collection)
          .doc(docId)
          .delete();
    }
  }

  Future<List<Map<String, dynamic>>> getCollection({
    required String collection,
    required String docId,
    required String subCollection,
  }) async {
    final snapshot = await _firestore
        .collection(collection)
        .doc(docId)
        .collection(subCollection)
        .get();

    return snapshot.docs.map((doc) {
      return {
        'id': doc.id, // مهم جدًا
        ...doc.data(),
      };
    }).toList();
  }


}