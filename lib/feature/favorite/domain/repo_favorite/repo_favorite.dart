
import '../../../menu/data/model/menu_model.dart';

abstract class RepoFavorite{
  Future<List<MenuModel>> getFavorite(String userId);
  Future<void> addToFavorite({required String uid, required MenuModel menu,});
  Future<void> removeFromFavorite({required String uid, required String itemId,});
}