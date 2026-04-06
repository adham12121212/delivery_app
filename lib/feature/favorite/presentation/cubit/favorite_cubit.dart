import 'package:bloc/bloc.dart';
import 'package:delivery_app/feature/favorite/domain/repo_favorite/repo_favorite.dart';
import 'package:delivery_app/feature/menu/data/model/menu_model.dart';
import 'package:meta/meta.dart';

part 'favorite_state.dart';

class FavoriteCubit extends Cubit<FavoriteState> {
  FavoriteCubit(this.repoFavorite) : super(FavoriteInitial());
  final RepoFavorite repoFavorite;

  Future<void> getFavorite(String userId)async{
    emit(FavoriteLoading());
    try{
      final data = await repoFavorite.getFavorite(userId);
      emit(FavoriteLoad(data));
    }on Exception catch (e) {
      emit(FavoriteError(e.toString()));
    }
  }


  Future<void> toggleFavorite(String userId, MenuModel item) async {
    final currentState = state;

    if (currentState is FavoriteLoad) {
      final exists = currentState.favorite.any((e) => e.id == item.id);

      List<MenuModel> updatedList;

      if (exists) {
        updatedList = currentState.favorite
            .where((e) => e.id != item.id)
            .toList();
      } else {
        updatedList = List.from(currentState.favorite)..add(item);
      }

      emit(FavoriteLoad(updatedList));

      try {
        if (exists) {
          await repoFavorite.removeFromFavorite(uid: userId, itemId: item.id);
        } else {
          await repoFavorite.addToFavorite(uid: userId, menu: item);
        }
      } catch (e) {
        emit(FavoriteError(e.toString()));
      }
    }
  }
  Future<void> removeFromFavorite(String userId, String itemId) async {
    final currentState = state;

    if (currentState is FavoriteLoad) {
      final updatedList = currentState.favorite
          .where((e) => e.id != itemId)
          .toList();

      emit(FavoriteLoad(updatedList));
    }

    try {
      await repoFavorite.removeFromFavorite(
        uid: userId,
        itemId: itemId,
      );
    } catch (e) {
      emit(FavoriteError(e.toString()));
    }
  }


}
