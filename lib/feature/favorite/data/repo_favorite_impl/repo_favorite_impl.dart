import 'package:delivery_app/feature/favorite/domain/repo_favorite/repo_favorite.dart';
import 'package:delivery_app/feature/menu/data/model/menu_model.dart';
import 'package:firebase_auth/firebase_auth.dart';

import '../../../../core/erorr/api_exception.dart';
import '../../../../core/erorr/firebase_auth_error_mapper.dart';
import '../../../../core/service/firestore_data.dart';

class RepoFavoriteImpl implements RepoFavorite{
  final FireStoreData fireStoreData;
  RepoFavoriteImpl(this.fireStoreData);


  @override
  Future<void> addToFavorite({required String uid, required MenuModel menu}) async{

    await fireStoreData.setDocument(
      collection: 'user',
      docId: uid,
      subCollection: 'favorite',
      subDocId: menu.id,
      data: {
        'name': menu.name,
        'image': menu.image,
        'price': menu.price,
        'menuCategory': menu.menuCategory,
      },
    );
  }

  @override
  Future<List<MenuModel>> getFavorite(String userId) async {
    try {
      final data = await fireStoreData.getCollection(
        collection: 'user',
        docId: userId,
        subCollection: 'favorite',
      );

      return data.map<MenuModel>((e) {
        return MenuModel.fromJson(e, e['id']);
      }).toList();

    } on FirebaseAuthException catch (e) {
      throw FirebaseAuthErrorMapper.map(e);
    } on ApiException {
      rethrow;
    } catch (_) {
      throw ApiException('حدث خطأ غير متوقع');
    }
  }

  @override
  Future<void> removeFromFavorite({  required String uid, required String itemId,}) async{
    try {
      await fireStoreData.deleteDocument(
        collection: 'user',
        docId: uid,
        subCollection: 'favorite',
        subDocId: itemId,
      );
    } on FirebaseAuthException catch (e) {
      throw FirebaseAuthErrorMapper.map(e);
    } on ApiException {
      rethrow;
    } catch (_) {
      throw ApiException('حدث خطأ أثناء حذف العنصر');
    }
  }

}