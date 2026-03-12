import 'package:bloc/bloc.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:meta/meta.dart';
import '../../data/model/cart_item_model.dart';

part 'cart_state.dart';

class CartCubit extends Cubit<CartState> {
  CartCubit() : super(CartInitial());

  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  void listenCart() {
    final String uid = FirebaseAuth.instance.currentUser!.uid;
    _firestore.collection('user')
        .doc(uid).collection('cart')
        .snapshots().listen((snapshot)
    {
      final items = snapshot.docs.map((doc) => CartItemModel.fromMap(doc.data())).toList();
      emit(CartLoaded(items: items));
    }, onError: (e) {
      emit(CartError('فشل تحميل السلة'));
    });
  }

  Future<void> addItem(CartItemModel item) async {
    final String uid = FirebaseAuth.instance.currentUser!.uid;
    try {
      await _firestore.collection('user').doc(uid).collection('cart').doc(item.id).set(item.toMap());
    } catch (e) {
      emit(CartError('فشل إضافة العنصر للسلة'));
    }
  }

  Future<void> updateQuantity(String itemId, int quantity) async {
    final String uid = FirebaseAuth.instance.currentUser!.uid;

    if (state is! CartLoaded) return;

    final items = List<CartItemModel>.from((state as CartLoaded).items);
    final index = items.indexWhere((e) => e.id == itemId);

    if (index >= 0) {
      final newItem = items[index].copyWith(
          quantity: quantity, totalPrice: items[index].price * quantity,);

      await _firestore.collection('user').doc(uid).collection('cart').doc(itemId).update({
        'quantity': newItem.quantity,
        'totalPrice': newItem.totalPrice,
      });
    }
  }

  Future<void> removeItem(String itemId) async {
    final String uid = FirebaseAuth.instance.currentUser!.uid;

    await _firestore.collection('user').doc(uid).collection('cart').doc(itemId).delete();
  }
}