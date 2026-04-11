part of 'favorite_cubit.dart';

@immutable
sealed class FavoriteState {}

final class FavoriteInitial extends FavoriteState {}

final class FavoriteLoading extends FavoriteState{}

final class FavoriteLoad extends FavoriteState{
  final List<MenuModel> favorite;
  FavoriteLoad(this.favorite);
}

final class FavoriteError extends FavoriteState{
  final String message;
  FavoriteError(this.message);
}
