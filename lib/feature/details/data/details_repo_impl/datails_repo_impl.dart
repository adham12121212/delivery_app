
import 'package:delivery_app/feature/menu/data/model/menu_model.dart';

import '../../../../core/service/firestore_data.dart';
import '../../domain/details_repo/details_repo.dart';

class DetailsRepoImpl implements DetailsRepo {
  final FireStoreData fireStoreData;

  DetailsRepoImpl(this.fireStoreData);

  @override
  Future<void> addToCart({
    required String uid,
    required MenuModel menu,
    required int quantity,
    required double totalPrice,
  }) async {

    await fireStoreData.setDocument(
      collection: 'user',
      docId: uid,
      subCollection: 'cart',
      subDocId: menu.id,
      data: {
        'name': menu.name,
        'image': menu.image,
        'price': menu.price,
        'quantity': quantity,
        'totalPrice': totalPrice,
      },
    );
  }
}