import 'package:delivery_app/feature/menu/data/model/menu_model.dart';
import 'package:flutter/foundation.dart';
import '../../../../core/erorr/api_exception.dart';
import '../../../../core/service/firestore_data.dart';
import '../../domain/menu_repo/menu_repo.dart';

class MenuRepoImpl implements MenuRepo {

  final FireStoreData fireStoreData;

  MenuRepoImpl(this.fireStoreData);

  @override
  Future<List<MenuModel>> getMenu(String restaurantId) async {
    try {
      final data = await fireStoreData.getMenu(restaurantId);
      return data;
    } catch (e) {
      debugPrint("MenuRepo Error: $e");
      throw ApiException('حدث خطأ غير متوقع');
    }
  }
}